# Create custom vpc
resource "google_compute_network" "vpc_network" {
  name                            = var.vpc_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
}

# Create webapp subnet
resource "google_compute_subnetwork" "webapp_subnet" {
  name          = var.webapp_subnet_name
  ip_cidr_range = var.webapp_subnet_cidr
  network       = google_compute_network.vpc_network.self_link
  region        = var.webapp_subnet_region

}

# Create db subnet
resource "google_compute_subnetwork" "db_subnet" {
  name          = var.db_subnet_name
  ip_cidr_range = var.db_subnet_cidr
  network       = google_compute_network.vpc_network.self_link
  region        = var.db_subnet_region

}

# Create webapp route
resource "google_compute_route" "webapp_route" {
  name             = var.webapp_route_name
  network          = google_compute_network.vpc_network.self_link
  dest_range       = var.webapp_route_dest_range
  next_hop_gateway = var.webapp_route_next_hop_gateway
  description      = "Route for webapp subnet"
  tags             = var.webapp_route_tag
}

# Create firewall allow rule app port 8080
resource "google_compute_firewall" "allow_app" {
  name               = var.firewall_allow_app_name
  network            = google_compute_network.vpc_network.self_link
  priority           = 1000
  direction          = var.firewall_allow_app_direction
  source_ranges      = var.firewall_allow_app_source_ranges
  destination_ranges = var.firewall_allow_app_destination_ranges
  target_tags        = var.firewall_allow_app_target_tags
  allow {
    protocol = var.firewall_allow_app_protocol
    ports    = var.firewall_allow_app_ports
  }
}

# Create firewall deny rule ssh port 22
resource "google_compute_firewall" "deny_ssh" {
  name               = var.firewall_deny_ssh_name
  network            = google_compute_network.vpc_network.self_link
  priority           = 1001
  direction          = var.firewall_deny_ssh_direction
  source_ranges      = var.firewall_deny_ssh_source_ranges
  destination_ranges = var.firewall_deny_ssh_destination_ranges
  target_tags        = var.firewall_deny_ssh_target_tags
  deny {
    protocol = var.firewall_deny_ssh_protocol
    ports    = var.firewall_deny_ssh_ports
  }
}

# Create custom image packer family
data "google_compute_image" "custom_image" {
  project     = var.project_id
  most_recent = true
  family      = var.custom_image_family
}

#Create service account
resource "google_service_account" "service_account_ops" {
  account_id   = var.ops_service_account_id
  display_name = var.ops_service_account_name
}

# Create IAM bindings for Logging admin role
resource "google_project_iam_binding" "logging_admin" {
  project = var.project_id
  role    = var.ops_service_account_logging_admin_role

  members = [
    "serviceAccount:${google_service_account.service_account_ops.email}"
  ]
}

# Create IAM bindings for Monitoring metrics writer role
resource "google_project_iam_binding" "metrics_writer" {
  project = var.project_id
  role    = var.ops_service_account_metrics_writer_role

  members = [
    "serviceAccount:${google_service_account.service_account_ops.email}"
  ]
}

# Create instance for app
resource "google_compute_instance" "instance" {
  name         = var.instance_name
  machine_type = var.instance_machinetype
  zone         = var.instance_zone

  boot_disk {
    initialize_params {
      image = data.google_compute_image.custom_image.self_link
      type  = var.instance_imagetype
      size  = var.instance_size
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.webapp_subnet.self_link
    access_config {}
  }

  tags = var.instance_tags

  metadata = {
    startup-script = <<-EOT
    #!/bin/bash

sudo cat << EOF | sudo tee /opt/csye6225/.env
DB_HOST="${google_sql_database_instance.my_database_instance.private_ip_address}"
DB_USER="${google_sql_user.my_database_sql_user.name}"
DB_PASSWORD="${google_sql_user.my_database_sql_user.password}"
DB_NAME="${google_sql_database.my_database_sql.name}"
PORT="${var.env_app_port}"
DB_PORT="${var.env_mysql_port}"
EOF


sudo systemctl restart csye6225.service
sudo systemctl restart google-cloud-ops-agent

EOT
  }

  service_account {
    email  = google_service_account.service_account_ops.email
    scopes = var.ops_service_account_instance_scopes
  }

  allow_stopping_for_update = true
}




# Allocate an IP address range
resource "google_compute_global_address" "private_ip_address" {
  name          = var.private_ip_address_name
  purpose       = var.private_ip_address_purpose
  address_type  = var.private_ip_address_address_type
  prefix_length = var.private_ip_address_prefix_length
  network       = google_compute_network.vpc_network.self_link
}

# Create a private connection 
resource "google_service_networking_connection" "connection" {
  network                 = google_compute_network.vpc_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# Create CloudSQL database instance
resource "google_sql_database_instance" "my_database_instance" {
  name             = var.my_database_instance_name
  region           = var.my_database_instance_region
  database_version = var.my_database_instance_database_version
  settings {
    tier              = var.my_database_instance_tier
    availability_type = var.my_database_instance_availability_type
    disk_type         = var.my_database_instance_disk_type
    disk_size         = var.my_database_instance_disk_size
    ip_configuration {
      ipv4_enabled                                  = var.my_database_instance_ipv4_enabled
      private_network                               = google_compute_network.vpc_network.self_link
      enable_private_path_for_google_cloud_services = true
    }
    backup_configuration {
      enabled            = true
      binary_log_enabled = true
    }
  }
  deletion_protection = var.my_database_instance_deletion_protection
  depends_on          = [google_service_networking_connection.connection]
}

# Create CloudSQL database
resource "google_sql_database" "my_database_sql" {
  name     = var.my_database_sql_name
  instance = google_sql_database_instance.my_database_instance.name
}

# Generate a random password for the database user
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Create CloudSQL database user
resource "google_sql_user" "my_database_sql_user" {
  name     = var.my_database_sql_user_name
  instance = google_sql_database_instance.my_database_instance.name
  password = random_password.db_password.result
}

#Create A record for domain
resource "google_dns_record_set" "Arecord" {
  name = var.google_dns_record_A_name
  type = var.google_dns_record_A_type
  ttl  = var.google_dns_record_A_ttl

  managed_zone = var.google_dns_record_A_zone

  rrdatas = [google_compute_instance.instance.network_interface[0].access_config[0].nat_ip]
}

