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
  tags             = var.webapp_route_tag
}

# Create firewall allow rule app port 8080
resource "google_compute_firewall" "allow_app" {
  name               = var.firewall_allow_app_name
  network            = google_compute_network.vpc_network.self_link
  priority           = var.firewall_allow_app_priority
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
  priority           = var.firewall_deny_ssh_priority
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
  most_recent = var.custom_image_most_recent
  family      = var.custom_image_family
}

#Create service account for ops
resource "google_service_account" "service_account_vm" {
  account_id   = var.vm_service_account_id
  display_name = var.vm_service_account_name
}

# Create IAM bindings for Logging admin role
resource "google_project_iam_binding" "logging_admin" {
  project = var.project_id
  role    = var.vm_service_account_logging_admin_role

  members = [
    "serviceAccount:${google_service_account.service_account_vm.email}"
  ]
}

# Create IAM bindings for Monitoring metrics writer role
resource "google_project_iam_binding" "metrics_writer" {
  project = var.project_id
  role    = var.vm_service_account_metrics_writer_role

  members = [
    "serviceAccount:${google_service_account.service_account_vm.email}"
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
PROJECT_ID= "${var.project_id}"
TOPIC_NAME="${google_pubsub_topic.verify_email.name}"
EOF


sudo systemctl restart csye6225.service
sudo systemctl restart google-cloud-ops-agent

EOT
  }

  service_account {
    email  = google_service_account.service_account_vm.email
    scopes = var.vm_service_account_instance_scopes
  }

  allow_stopping_for_update = var.instance_tags_allow_stopping_for_update
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
  service                 = var.connection_vpc_peering_service
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
      enable_private_path_for_google_cloud_services = var.my_database_instance_enable_private_path_for_google_cloud_services
    }
    backup_configuration {
      enabled            = var.my_database_instance_backup_enabled
      binary_log_enabled = var.my_database_instance_binary_log_enabled
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
  length           = var.my_database_sql_password_length
  special          = var.my_database_sql_password_special
  override_special = var.my_database_sql_password_override
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

#Create a pubsub topic
resource "google_pubsub_topic" "verify_email" {
  name                       = var.google_pubsub_topic_name
  message_retention_duration = var.google_pubsub_topic_message_retention_duration
}

#Create a pubsub subscription
resource "google_pubsub_subscription" "verify_email_subs" {
  name  = var.google_pubsub_subscription_name
  topic = google_pubsub_topic.verify_email.name

}

#Create pubsub topic IAM binding
resource "google_pubsub_topic_iam_binding" "pubsub_binding" {
  project = google_pubsub_topic.verify_email.project
  topic   = google_pubsub_topic.verify_email.name
  role    = var.pubsub_binding_role
  members = [
    "serviceAccount:${google_service_account.service_account_vm.email}",
  ]
}

#Create a service account for cloud function
resource "google_service_account" "service_account_cloud_function" {
  account_id   = var.service_account_cloud_function_id
  display_name = var.service_account_cloud_function_name
}

#Create a IAM binding for cloud function service account
resource "google_cloud_run_v2_service_iam_binding" "cloud_function_binding" {
  project  = google_cloudfunctions2_function.cloud_function_verify_email.project
  location = google_cloudfunctions2_function.cloud_function_verify_email.location
  name     = google_cloudfunctions2_function.cloud_function_verify_email.name
  role     = var.cloud_function_binding_role
  members = [
    "serviceAccount:${google_service_account.service_account_cloud_function.email}",
  ]
}
resource "random_id" "bucket_prefix" {
  byte_length = var.bucket_prefix
}

#Create a bucket to store cloud function code
resource "google_storage_bucket" "cloud_function_bucket" {
  name                        = "${random_id.bucket_prefix.hex}-gcf-bucket" # Globally unique
  location                    = var.cloud_function_bucket_location
  uniform_bucket_level_access = var.cloud_function_bucket_uniform_bucket_level_access
}

#Zipping Cloud function code
data "archive_file" "cloud_function_file" {
  type        = var.archive_file_type
  output_path = var.archive_file_output_path
  source_dir  = var.archive_file_source_dir
}

#Creating object in bucket to store serverless zip
resource "google_storage_bucket_object" "cloud_function_bucket_object" {
  name   = var.cloud_function_bucket_object_name
  bucket = google_storage_bucket.cloud_function_bucket.name
  source = data.archive_file.cloud_function_file.output_path # Path to the zipped function source code
}

#Creating cloud function
resource "google_cloudfunctions2_function" "cloud_function_verify_email" {
  name        = var.cloud_function_verify_email_name
  location    = var.cloud_function_verify_email_location
  description = var.cloud_function_verify_email_description

  build_config {
    runtime     = var.cloud_function_verify_email_build_runtime
    entry_point = var.cloud_function_verify_email_build_enrtypoint
    environment_variables = {

    }
    source {
      storage_source {
        bucket = google_storage_bucket.cloud_function_bucket.name
        object = google_storage_bucket_object.cloud_function_bucket_object.name
      }
    }
  }

  service_config {
    max_instance_count = var.cloud_function_verify_email_service_max_instance_count
    min_instance_count = var.cloud_function_verify_email_service_min_instance_count
    available_memory   = var.cloud_function_verify_email_service_available_memory
    timeout_seconds    = var.cloud_function_verify_email_service_timeout_seconds
    environment_variables = {
      DB_HOST     = "${google_sql_database_instance.my_database_instance.private_ip_address}"
      DB_USER     = "${google_sql_user.my_database_sql_user.name}"
      DB_PASSWORD = "${google_sql_user.my_database_sql_user.password}"
      DB_NAME     = "${google_sql_database.my_database_sql.name}"
      DB_PORT     = "${var.env_mysql_port}"

    }
    ingress_settings               = var.cloud_function_verify_email_service_ingress_settings
    vpc_connector                  = google_vpc_access_connector.cfconnector.self_link
    all_traffic_on_latest_revision = var.cloud_function_verify_email_service_all_traffic_on_latest_revision
    service_account_email          = google_service_account.service_account_cloud_function.email
  }

  event_trigger {
    trigger_region        = var.cloud_function_verify_email_trigger_region
    event_type            = var.cloud_function_verify_email_event_type
    pubsub_topic          = google_pubsub_topic.verify_email.id
    retry_policy          = var.cloud_function_verify_email_retry_policy
    service_account_email = google_service_account.service_account_cloud_function.email
  }

}

//Created Serverless VPC Access
resource "google_vpc_access_connector" "cfconnector" {
  name          = var.google_vpc_access_connector_name
  region        = var.google_vpc_access_connector_region
  ip_cidr_range = var.google_vpc_access_connector_ip_cidr_range
  network       = google_compute_network.vpc_network.self_link
}
