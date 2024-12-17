terraform {
  required_providers {
    google = {
      source     = "hashicorp/google"
      version    = "6.8.0"
    }
  }
}

provider "google" {
  project        = var.project_id
  region         = var.region
}

module "network"{
  source         = "./modules/network"

  region         = var.region
  project_id     = var.project_id
  network_name   = var.network_name
}