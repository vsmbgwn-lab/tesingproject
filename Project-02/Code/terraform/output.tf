output "vpc_network" {
  value = module.vpc.network_name
}

output "vpc_subnetwork" {
  value = module.vpc.subnet_name
}

output "gke_cluster" {
  value = module.gke.cluster_name
}

output "raw_bucket" {
  value = module.storage.raw_bucket_name
}

output "processed_bucket" {
  value = module.storage.proc_bucket_name
}

output "artifact_registry" {
  value = module.artifact_registry.repo_full_name
}

output "cloudsql_connection_name" {
  value = module.cloudsql.connection_name
}
