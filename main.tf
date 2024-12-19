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

module "build" {
  source         = "./modules/build"
  project_id     = var.project_id
  branch_name    = var.branch_name
  backend_repository_id = var.backend_repository_id
  region         = var.region
  backend_cloudbuild = var.backend_cloudbuild
  github_owner      = var.github_owner
  github_repo_name  = var.github_repo_name
}