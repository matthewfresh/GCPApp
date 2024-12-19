resource "google_artifact_registry_repository" "backend-repo" {
  location      = var.region
  repository_id = var.backend_repository_id
  description   = "Docker Repository for GCPApp backend"
  format        = "DOCKER"
}

resource "google_cloudbuild_trigger" "backend-trigger" {
  name = var.backend_cloudbuild

  github {
    owner   = var.github_owner
    name    = var.github_repo_name
    push {
        branch  = var.branch_name
    }
  }

  substitutions = {
    _REGION      = var.region
    _PROJECT_ID  = var.project_id
  }

  filename = "cloudbuild.yaml"
}