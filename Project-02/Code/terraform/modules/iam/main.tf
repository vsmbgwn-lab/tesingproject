resource "google_service_account" "gke_sa" {
  account_id   = var.gke_sa_id
  display_name = "GKE Workload Service Account"
}

resource "google_service_account" "cloudsql_sa" {
  account_id   = var.cloudsql_sa_id
  display_name = "Cloud SQL Service Account"
}

resource "google_service_account" "storage_sa" {
  account_id   = var.storage_sa_id
  display_name = "Storage Access Service Account"
}

resource "google_project_iam_member" "artifact_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

resource "google_project_iam_member" "storage_admin" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.storage_sa.email}"
}

resource "google_project_iam_member" "cloudsql_client" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cloudsql_sa.email}"
}
