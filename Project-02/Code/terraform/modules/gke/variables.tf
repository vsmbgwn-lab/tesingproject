variable "project_id" { type = string }
variable "region" { type = string }
variable "network" { type = string }
variable "subnetwork" { type = string }
variable "cluster_name" { type = string }
variable "initial_node_count" { type = number }
variable "gke_sa_email" { type = string }
variable "artifact_registry_repo" { type = string }
