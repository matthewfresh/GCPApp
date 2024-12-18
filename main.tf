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

module "network" {
  source         = "./modules/network"
  network_name   = var.network_name
}

module "storage" {
  source         = "./modules/storage"
  bucket_name    = var.bucket_name
  region         = var.region
}