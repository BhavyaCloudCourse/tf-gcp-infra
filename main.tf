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
  region        = each.value.region
  network       = each.value.network
}
resource "google_compute_route" "webapp_route" {
  for_each         = var.vpcs
  name             = each.value.route_name
  network          = google_compute_network.vpc_network[each.key].self_link
  dest_range       = each.value.dest_range
  next_hop_gateway = each.value.next_hop_gateway
  description      = "Route for webapp subnet"
  tags             = ["webapp"]
}

# Create firewall rule 
resource "google_compute_firewall" "app_firewall" {
  for_each = var.vpcs
  name     = "allow-app-traffic"
  network  = google_compute_network.vpc_network[each.key].self_link

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }


  source_ranges = ["0.0.0.0/0"]
}

# Create compute instance
resource "google_compute_instance" "my_instance" {
  for_each     = var.vpcs
  name         = "my-instance"
  machine_type = "e2-standard-2"
  zone       = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "packer-1708328426"
      # type  = "pd-balance"
      size  = 100
    }
  }

  network_interface {
    network = google_compute_network.vpc_network[each.key].self_link
    subnetwork = "webapp"
    access_config {}
  }
}
