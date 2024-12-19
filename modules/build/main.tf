data "google_project" "project" {
  project_id = var.project_id
}

# data "local_file" "backend_cloudbuild" {
#   filename = "${path.module}/backend_cloudbuild.yml"
# }

# data "local_file" "frontend_cloudbuild" {
#   filename = "${path.module}/frontend_cloudbuild.yml"
# }

# Define all the IAM roles and members in a map
locals {
  cloudbuild_roles = {
    "roles/cloudbuild.builds.builder"     = "projects/${var.project_id}/serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com",
    "roles/artifactregistry.repoAdmin"    = "projects/${var.project_id}/serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com",
    "roles/artifactregistry.writer"       = "projects/${var.project_id}/serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com",
    "roles/run.admin"                     = "projects/${var.project_id}/serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com",
    "roles/iam.serviceAccountUser"        = "projects/${var.project_id}/serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
  }
}

# Create Artifact Registry repository for backend Docker images
resource "google_artifact_registry_repository" "backend-repo" {
  location      = var.region
  repository_id = var.backend_repository_id
  description   = "Docker Repository for GCPApp backend"
  format        = "DOCKER"
}

# Cloud Build Trigger for the backend repository
resource "google_cloudbuild_trigger" "backend-trigger" {
  name = var.backend_cloudbuild
  location = var.region

  # Github repo is public
  trigger_template {
    branch_name = var.branch_name
    repo_name   = "github_${var.github_owner}_${var.github_repo_name}"  # Note the format
    project_id  = var.project_id
  }

  # # Github repo is private
  # github {
  #   owner = var.github_owner
  #   name  = var.github_repo_name
  #   push {
  #     branch = var.branch_name
  #   }
  # }

  substitutions = {
    _REGION      = var.region
    _PROJECT_ID  = var.project_id
  }

  filename = "backend_cloudbuild.yml"
}

# Note: The service account ID follows the pattern: project-number@cloudbuild.gserviceaccount.com
resource "google_project_iam_member" "cloudbuild_permissions" {
  for_each = local.cloudbuild_roles
  
  project = var.project_id
  role    = each.key
  member  = each.value

  depends_on = [
    google_artifact_registry_repository.backend-repo,
    google_cloudbuild_trigger.backend-trigger
  ]
}