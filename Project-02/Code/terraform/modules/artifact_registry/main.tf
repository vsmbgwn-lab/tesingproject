resource "google_artifact_registry_repository" "repo" {
  repository_id = var.repo_id
  project       = var.project_id
  location      = var.location
  format        = "DOCKER"
  description   = var.description
}
