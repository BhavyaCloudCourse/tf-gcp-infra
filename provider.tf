provider "google" {
  project = var.project_id
  region  = var.region
}
provider "google-beta" {
  region  = var.region
  zone    = var.instance_zone
  project = var.project_id
}