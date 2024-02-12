provider "google" {

  project = var.project_id
  region  = var.region


resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "webapp_subnet" {
  name          = "webapp"
  ip_cidr_range = var.webapp_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = "db"
  ip_cidr_range = var.db_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.self_link
}

# Route for webapp subnet (with destination CIDR range 0.0.0.0/0)
resource "google_compute_route" "webapp_route" {
  name             = "webapp-route"
  network          = google_compute_network.vpc_network.self_link
  dest_range       = "0.0.0.0/0" 
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
  description      = "Route for webapp subnet"
}
