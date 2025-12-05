resource "google_container_cluster" "gke" {
  name     = var.cluster_name
  location = var.region

  network    = var.network
  subnetwork = var.subnetwork

  remove_default_node_pool = true
  initial_node_count       = 1

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "pool" {
  name       = "${var.cluster_name}-pool"
  location   = var.region
  cluster    = google_container_cluster.gke.name
  node_count = var.initial_node_count

  node_config {
    machine_type    = "e2-medium"
    service_account = var.gke_sa_email
  }
}
