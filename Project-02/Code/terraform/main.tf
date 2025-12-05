# Terraform starter for Project-02 — provider + modules

terraform {
  required_version = ">= 1.4.0"

  backend "gcs" {
  bucket = "project02-tfstate-bucket"
  prefix = "project02/terraform"
}

}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# --------------------------------------------------
# VPC Module
# --------------------------------------------------
module "vpc" {
  source       = "./modules/vpc"
  project_id   = var.project_id
  network_name = "project02-vpc"
  region       = var.region
}

# --------------------------------------------------
# Storage Module
# --------------------------------------------------
module "storage" {
  source            = "./modules/storage"
  project_id        = var.project_id
  location          = var.region
  raw_bucket_name   = "${var.project_id}-raw-bucket"
  proc_bucket_name  = "${var.project_id}-processed-bucket"
  raw_lifecycle_age = 30
  proc_lifecycle_age = 60
}

# --------------------------------------------------
# Artifact Registry Module
# --------------------------------------------------
module "artifact_registry" {
  source      = "./modules/artifact_registry"
  project_id  = var.project_id
  location    = var.region
  repo_id     = "project02-docker"
  description = "Docker repo for Project-02"
}

# --------------------------------------------------
# IAM Module
# --------------------------------------------------
module "iam" {
  source         = "./modules/iam"
  project_id     = var.project_id
  gke_sa_id      = "gke-workload-sa"
  cloudsql_sa_id = "cloudsql-client-sa"
  storage_sa_id  = "storage-access-sa"
}

# --------------------------------------------------
# GKE Module
# --------------------------------------------------
module "gke" {
  source                 = "./modules/gke"
  project_id             = var.project_id
  region                 = var.region
  network                = module.vpc.network_name
  subnetwork             = module.vpc.subnet_name
  cluster_name           = "project02-gke"
  initial_node_count     = 1
  gke_sa_email           = module.iam.gke_sa_email
  artifact_registry_repo = module.artifact_registry.repo_full_name
}

# --------------------------------------------------
# Cloud SQL Module
# --------------------------------------------------
module "cloudsql" {
  source           = "./modules/cloudsql"
  project_id       = var.project_id
  region           = var.region
  instance_name    = "project02-sql"
  database_version = "POSTGRES_15"
  tier             = "db-f1-micro"
  db_name          = "project02db"
  db_user          = "project02user"
  db_password      = var.db_password
}
