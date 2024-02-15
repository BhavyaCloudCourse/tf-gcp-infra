resource "google_compute_network" "vpc_network" {
  for_each                        = var.vpcs
  name                            = each.key
  auto_create_subnetworks         = false
  routing_mode                    = "REGIONAL"
  delete_default_routes_on_create = true
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
