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
variable "custom_image_most_recent" {
  description = "GCE Custom Packer Img Most Recent"
}

variable "firewall_allow_app_name" {
  description = "firewall allow name"
}
variable "firewall_allow_app_direction" {
  description = "firewall_allow_app_port_direction"
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
variable "firewall_allow_app_priority" {
  description = "firewall_allow_app_priority"
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
variable "firewall_deny_ssh_priority" {
  description = "firewall_deny_ssh_priority"
}
variable "firewall_allow_healthz_name" {
  description = "firewall_deny_ssh_port_name"
}
variable "firewall_allow_healthz_direction" {
  description = "firewall_deny_ssh_port_direction"
}
variable "firewall_allow_healthz_source_ranges" {
  description = "firewall_deny_ssh_port_source_ranges"
}

variable "firewall_allow_healthz_target_tags" {
  description = "firewall_deny_ssh_port_target_tags"
}

variable "firewall_allow_healthz_protocol" {
  description = "firewall_deny_ssh_port_protocol"
}
variable "firewall_allow_healthz_ports" {
  description = "firewall_deny_ssh_ports"
}
variable "firewall_allow_healthz_priority" {
  description = "firewall_deny_ssh_priority"
}
variable "instance_temp_name" {
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
variable "instance_ip_forward" {
  description = "instance_ip_forward"
}
variable "instance_grp_name" {
  description = "instance_ip_forward"
}
variable "instance_grp_version_name" {
  description = "instance_ip_forward"
}
variable "instance_grp_base_instance_name" {
  description = "instance_ip_forward"
}
variable "instance_grp_named_port_name" {
  description = "instance_ip_forward"
}
variable "instance_grp_named_port_port" {
  description = "instance_ip_forward"
}
variable "instance_grp_health_chk_delay" {
  description = "instance_ip_forward"
}
variable "autoscaler_name" {
  description = "instance_ip_forward"
}
variable "autoscaler_max_replicas" {
  description = "instance_ip_forward"
}
variable "autoscaler_min_replicas" {
  description = "instance_ip_forward"
}
variable "autoscaler_cooldown_period" {
  description = "instance_ip_forward"
}
variable "autoscaler_cpu_util" {
  description = "instance_ip_forward"
}
variable "private_ip_address_name" {
  description = "private_ip_address_name"
}
variable "private_ip_address_purpose" {
  description = "private_ip_address_purpose"
}
variable "private_ip_address_address_type" {
  description = "private_ip_address_address_type"
}
variable "private_ip_address_prefix_length" {
  description = "private_ip_address_prefix_length"
}
variable "connection_vpc_peering_service" {
  description = "connection_vpc_peering_service"
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
variable "my_database_instance_enable_private_path_for_google_cloud_services" {
  description = "my_database_instance_enable_private_path_for_google_cloud_services"
}
variable "my_database_instance_backup_enabled" {
  description = "my_database_instance_backup_enabled"
}
variable "my_database_instance_binary_log_enabled" {
  description = "my_database_instance_binary_log_enabled"
}
variable "my_database_sql_name" {
  description = "my_database_sql_name"
}
variable "my_database_sql_user_name" {
  description = "my_database_sql_user_namer"
}
variable "my_database_sql_password_length" {
  description = "my_database_sql_password_length"
}
variable "my_database_sql_password_special" {
  description = "my_database_sql_password_special"
}
variable "my_database_sql_password_override" {
  description = "my_database_sql_password_override"
}

variable "env_app_port" {
  description = "app port in env file"
}
variable "env_mysql_port" {
  description = "mysql port in env file"
}

variable "vm_service_account_id" {
  description = "ops service account id"
}
variable "vm_service_account_name" {
  description = "ops service account name"
}
variable "vm_service_account_metrics_writer_role" {
  description = "ops service account metric writer role"
}
variable "vm_service_account_logging_admin_role" {
  description = "ops service account logging admin role"
}
variable "vm_service_account_instance_scopes" {
  description = "ops service account scopes"
}
variable "google_dns_record_A_name" {
  description = "google_dns_record_A_name"
}
variable "google_dns_record_A_type" {
  description = "google_dns_record_A_type"
}
variable "google_dns_record_A_ttl" {
  description = "google_dns_record_A_ttl"
}
variable "google_dns_record_A_zone" {
  description = "google_dns_record_A_zone"
}
variable "google_vpc_access_connector_region" {
  description = "google_vpc_access_connector_region"
}
variable "google_vpc_access_connector_ip_cidr_range" {
  description = "google_vpc_access_connector_ip_cidr_range"
}
variable "google_vpc_access_connector_name" {
  description = "google_vpc_access_connector_name"
}
variable "google_pubsub_topic_name" {
  description = "google_pubsub_topic_name"
}
variable "google_pubsub_topic_message_retention_duration" {
  description = "google_pubsub_topic_message_retention_duration"
}
variable "google_pubsub_subscription_name" {
  description = "google_pubsub_subscription_name"
}
variable "pubsub_binding_role" {
  description = "pubsub_binding_role"
}
variable "service_account_cloud_function_id" {
  description = "service_account_cloud_function_id"
}
variable "service_account_cloud_function_name" {
  description = "service_account_cloud_function_name"
}
variable "cloud_function_binding_role" {
  description = "cloud_function_binding_role"
}
variable "archive_file_type" {
  description = "archive_file_type"
}
variable "archive_file_output_path" {
  description = "archive_file_output_path"
}
variable "archive_file_source_dir" {
  description = "archive_file_source_dir"
}
variable "cloud_function_bucket_object_name" {
  description = "cloud_function_bucket_object_name"
}
variable "cloud_function_verify_email_name" {
  description = "cloud_function_verify_email_name"
}
variable "cloud_function_verify_email_location" {
  description = "cloud_function_verify_email_location"
}
variable "cloud_function_verify_email_description" {
  description = "cloud_function_verify_email_description"
}
variable "cloud_function_verify_email_build_runtime" {
  description = "cloud_function_verify_email_build_runtime"
}
variable "cloud_function_verify_email_build_enrtypoint" {
  description = "cloud_function_verify_email_build_enrtypoint"
}
variable "cloud_function_verify_email_service_max_instance_count" {
  description = "cloud_function_verify_email_service_max_instance_count"
}
variable "cloud_function_verify_email_service_min_instance_count" {
  description = "cloud_function_verify_email_service_min_instance_count"
}
variable "cloud_function_verify_email_service_available_memory" {
  description = "cloud_function_verify_email_service_available_memory"
}
variable "cloud_function_verify_email_service_timeout_seconds" {
  description = "cloud_function_verify_email_service_timeout_seconds"
}
variable "cloud_function_verify_email_service_ingress_settings" {
  description = "cloud_function_verify_email_service_ingress_settings"
}
variable "cloud_function_verify_email_service_all_traffic_on_latest_revision" {
  description = "cloud_function_verify_email_service_all_traffic_on_latest_revision"
}
variable "cloud_function_verify_email_trigger_region" {
  description = "cloud_function_verify_email_trigger_region"
}
variable "cloud_function_verify_email_event_type" {
  description = "cloud_function_verify_email_event_type"
}
variable "cloud_function_verify_email_retry_policy" {
  description = "cloud_function_verify_email_retry_policy"
}
variable "cloud_function_bucket_location" {
  description = "cloud_function_bucket_location"
}
variable "cloud_function_bucket_uniform_bucket_level_access" {
  description = "cloud_function_bucket_uniform_bucket_level_access"
}
variable "bucket_prefix" {
  description = "bucket_prefix"
}

variable "health_check_name" {
  description = "cloud_function_verify_email_service_all_traffic_on_latest_revision"
}
variable "health_check_timeout_sec" {
  description = "cloud_function_verify_email_trigger_region"
}
variable "health_check_healthy_threshold" {
  description = "cloud_function_verify_email_event_type"
}
variable "health_check_unhealthy_threshold" {
  description = "cloud_function_verify_email_retry_policy"
}
variable "health_check_request_path" {
  description = "cloud_function_bucket_location"
}
variable "health_check_port" {
  description = "cloud_function_bucket_uniform_bucket_level_access"
}
variable "health_check_interval_sec" {
  description = "bucket_prefix"
}

variable "lb_global_IP_adresses_name" {
  description = "cloud_function_bucket_uniform_bucket_level_access"
}
variable "lb_global_IP_adresses_version" {
  description = "bucket_prefix"
}
variable "lb_bcknd_name" {
  description = "cloud_function_verify_email_service_all_traffic_on_latest_revision"
}
variable "lb_bcknd_connection_draining_timeout_sec" {
  description = "cloud_function_verify_email_trigger_region"
}
variable "lb_bcknd_load_balancing_scheme" {
  description = "cloud_function_verify_email_retry_policy"
}
variable "lb_bcknd_port_name" {
  description = "cloud_function_bucket_location"
}
variable "lb_bcknd_protocol" {
  description = "cloud_function_bucket_uniform_bucket_level_access"
}
variable "lb_bcknd_session_affinity" {
  description = "bucket_prefix"
}

variable "lb_bcknd_timeout_sec" {
  description = "cloud_function_bucket_uniform_bucket_level_access"
}
variable "lb_bcknd_balancing_mode" {
  description = "bucket_prefix"
}
variable "lb_bcknd_capacity_scaler" {
  description = "bucket_prefix"
}
variable "lb_url_map_name" {
  description = "bucket_prefix"
}
variable "lb_https_proxy_name" {
  description = "bucket_prefix"
}
variable "lb_frontend_name" {
  description = "bucket_prefix"
}

variable "lb_frontend_ip_protocol" {
  description = "cloud_function_bucket_uniform_bucket_level_access"
}
variable "lb_frontend_load_balancing_scheme" {
  description = "bucket_prefix"
}
variable "lb_frontend_port_range" {
  description = "bucket_prefix"
}
variable "lb_ssl_name" {
  description = "bucket_prefix"
}
variable "domain" {
  description = "bucket_prefix"
}