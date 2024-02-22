resource "google_compute_network" "vpc_network" {
  for_each                        = var.vpcs
  name                            = each.key
  auto_create_subnetworks         = each.value.auto_create_subnetworks
  routing_mode                    = each.value.routing_mode
  delete_default_routes_on_create = each.value.delete_default_routes_on_create
}

resource "google_compute_subnetwork" "subnet" {
  for_each = {
    for subnet in local.network_subnets : "${subnet.network_key}.${subnet.subnet_key}" => subnet
  }
  name          = each.value.subnet_key
  ip_cidr_range = each.value.cidr
  network       = each.value.network
  region        = each.value.region

}
resource "google_compute_route" "webapp_route" {
  for_each         = var.vpcs
  name             = each.value.route_name
  network          = google_compute_network.vpc_network[each.key].self_link
  dest_range       = each.value.dest_range
  next_hop_gateway = each.value.next_hop_gateway
  description      = "Route for webapp subnet"
  tags             = var.webapp_route_tag
}

data "google_compute_image" "custom_image" {
  project     = var.project_id
  most_recent = true
  family      = var.custom_image_family
}

resource "google_compute_firewall" "allow_http_8080" {
  for_each  = var.vpcs
  name      = var.firewall_allow_name
  network   = google_compute_network.vpc_network[each.key].self_link
  priority  = 1000
  direction = var.firewall_direction


  source_ranges      = var.source_ranges
  destination_ranges = var.destination_ranges

  target_tags = var.allow_target_tags

  allow {
    protocol = var.protocol
    ports    = var.allow_ports
  }
}

resource "google_compute_firewall" "block_ssh" {
  for_each  = var.vpcs
  name      = var.firewall_deny_name
  network   = google_compute_network.vpc_network[each.key].self_link
  priority  = 1001
  direction = var.firewall_direction

  source_ranges      = var.source_ranges
  destination_ranges = var.destination_ranges

  target_tags = var.disallow_target_tags
  deny {
    protocol = var.protocol
    ports    = var.disallow_ports
  }
}

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
    network    = google_compute_network.vpc_network["vpc2"].self_link
    subnetwork = google_compute_subnetwork.subnet["vpc2.webapp"].self_link
    access_config {}
  }

  tags = var.instance_target_tags
}
