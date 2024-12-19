variable "region" {
  description = "The GCP deployment region"
  type        = string
}

variable "backend_repository_id" {
  description = "The repository id of GCPApp backend"
  type        = string
}

variable "branch_name" {
  description = "The branch name of GCPApp backend"
  type        = string
}

variable "project_id" {
  description = "The project ID"
  type        = string
}

variable "backend_cloudbuild" {
  description = "The name of backend cloudbuild trigger"
  type        = string
}

variable "github_owner" {
  description = "github owner name"
  type        = string
}

variable "github_repo_name" {
  description = "github repo name"
  type        = string
}