variable "project_id" {
  description = "Google Cloud project ID"
}

variable "region" {
  description = "Google Cloud region"
}

variable "vpc_name" {
  description = "Name of the VPC"
}

variable "webapp_subnet_cidr" {
  description = "CIDR range for webapp subnet"
}

variable "db_subnet_cidr" {
  description = "CIDR range for db subnet"
}
