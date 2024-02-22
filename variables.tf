variable "project_id" {
  description = "Google Cloud project ID"
}

variable "region" {
  description = "Google Cloud region"
}
variable "webapp_route_tag" {
  description = "Google Cloud region"
}
variable "custom_image_family" {
  description = "Google Cloud region"
}

variable "firewall_allow_name" {
  description = "Google Cloud region"
}
variable "firewall_deny_name" {
  description = "Google Cloud region"
}
variable "firewall_direction" {
  description = "Google Cloud region"
}
variable "source_ranges" {
  description = "Google Cloud region"
}
variable "destination_ranges" {
  description = "Google Cloud region"
}
variable "allow_target_tags" {
  description = "Google Cloud region"
}
variable "disallow_target_tags" {
  description = "Google Cloud region"
}

variable "protocol" {
  description = "Google Cloud region"
}
variable "allow_ports" {
  description = "Google Cloud region"
}
variable "disallow_ports" {
  description = "Google Cloud region"
}
variable "instance_target_tags" {
  description = "Google Cloud region"
}
variable "instance_name" {
  description = "Google Cloud region"
}
variable "instance_machinetype" {
  description = "Google Cloud region"
}
variable "instance_zone" {
  description = "Google Cloud region"
}
variable "instance_imagetype" {
  description = "Google Cloud region"
}
variable "instance_size" {
  description = "Google Cloud region"
}

variable "vpcs" {
  description = "A list of VPC configurations"
  type = map(object({
    auto_create_subnetworks         = bool
    routing_mode                    = string
    delete_default_routes_on_create = bool
    subnets = map(object({
      cidr   = string
      region = string
    }))
    route_name       = string
    dest_range       = string
    next_hop_gateway = string

  }))
}

locals {
  # flatten ensures that this local value is a flat list of objects, rather
  # than a list of lists of objects.
  network_subnets = flatten([
    for network_key, network in var.vpcs : [
      for subnet_key, subnet in network.subnets : {
        network_key = network_key
        subnet_key  = subnet_key
        network     = google_compute_network.vpc_network[network_key].self_link
        cidr        = subnet.cidr
        region      = subnet.region
      }
    ]
  ])
}
