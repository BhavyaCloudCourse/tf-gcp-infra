variable "project_id" {
  description = "Google Cloud project ID"
}
variable "region" {
  description = "Google Cloud region"
}
variable "vpc_name" {
  description = "Name of custom vpc"
}
variable "auto_create_subnetworks" {
  description = "auto create subnetworks setting"
}
variable "routing_mode" {
  description = "routing mode setting"
}
variable "delete_default_routes_on_create" {
  description = "delete default routes on create setting"
}

variable "webapp_subnet_name" {
  description = "Name of webapp subnet"
}
variable "webapp_subnet_cidr" {
  description = "webapp subnet cidr range"
}
variable "webapp_subnet_region" {
  description = "webapp subnet region"
}
variable "db_subnet_name" {
  description = "Name of db subnet "
}
variable "db_subnet_cidr" {
  description = "db subnet cidr range"
}
variable "db_subnet_region" {
  description = "db subnet region"
}

variable "webapp_route_name" {
  description = "webapp route name"
}
variable "webapp_route_dest_range" {
  description = "webapp route destination range"
}
variable "webapp_route_next_hop_gateway" {
  description = "webapp route gateway"
}
variable "webapp_route_tag" {
  description = "webapp route tag"
}
variable "custom_image_family" {
  description = "GCE Custom Packer Img"
}

variable "firewall_allow_app_name" {
  description = "firewall allow name"
}
variable "firewall_allow_app_direction" {
  description = "firewall_allow_app_port_direction"
}
variable "firewall_allow_app_source_ranges" {
  description = "firewall_allow_app_port_source_ranges"
}
variable "firewall_allow_app_destination_ranges" {
  description = "firewall_allow_app_port_destination_range"
}
variable "firewall_allow_app_target_tags" {
  description = "firewall_allow_app_port_target_tags"
}

variable "firewall_allow_app_protocol" {
  description = "firewall_allow_app_port_protocol"
}
variable "firewall_allow_app_ports" {
  description = "firewall_allow_app_ports"
}

variable "firewall_deny_ssh_name" {
  description = "firewall_deny_ssh_port_name"
}
variable "firewall_deny_ssh_direction" {
  description = "firewall_deny_ssh_port_direction"
}
variable "firewall_deny_ssh_source_ranges" {
  description = "firewall_deny_ssh_port_source_ranges"
}
variable "firewall_deny_ssh_destination_ranges" {
  description = "firewall_deny_ssh_port_destination_ranges"
}
variable "firewall_deny_ssh_target_tags" {
  description = "firewall_deny_ssh_port_target_tags"
}

variable "firewall_deny_ssh_protocol" {
  description = "firewall_deny_ssh_port_protocol"
}
variable "firewall_deny_ssh_ports" {
  description = "firewall_deny_ssh_ports"
}
variable "instance_name" {
  description = "instance_name"
}
variable "instance_machinetype" {
  description = "instance_machinetype"
}
variable "instance_zone" {
  description = "instance_zone"
}
variable "instance_imagetype" {
  description = "instance_imagetype"
}
variable "instance_size" {
  description = "instance_size"
}
variable "instance_tags" {
  description = "instance_target_tags"
}
variable "private_ip_address_name" {
  description = "instance_zone"
}
variable "private_ip_address_purpose" {
  description = "instance_imagetype"
}
variable "private_ip_address_address_type" {
  description = "private_ip_address_address_type"
}
variable "private_ip_address_prefix_length" {
  description = "private_ip_address_prefix_length"
}
variable "my_database_instance_name" {
  description = "my_database_instance_name"
}
variable "my_database_instance_region" {
  description = "my_database_instance_region"
}
variable "my_database_instance_database_version" {
  description = "my_database_instance_database_version"
}
variable "my_database_instance_tier" {
  description = "my_database_instance_tier"
}
variable "my_database_instance_availability_type" {
  description = "my_database_instance_availability_type"
}
variable "my_database_instance_disk_type" {
  description = "my_database_instance_disk_type"
}
variable "my_database_instance_disk_size" {
  description = "my_database_instance_disk_size"
}
variable "my_database_instance_ipv4_enabled" {
  description = "my_database_instance_ipv4_enabled"
}
variable "my_database_instance_deletion_protection" {
  description = "my_database_instance_deletion_protection"
}
variable "my_database_sql_name" {
  description = "my_database_sql_name"
}
variable "my_database_sql_user_name" {
  description = "my_database_sql_user_namer"
}
variable "env_app_port" {
  description = "app port in env file"
}
variable "env_mysql_port" {
  description = "mysql port in env file"
}

