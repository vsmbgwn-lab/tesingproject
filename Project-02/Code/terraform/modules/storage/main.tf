resource "google_storage_bucket" "raw" {
  name     = var.raw_bucket_name
  location = var.location
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition { age = var.raw_lifecycle_age }
    action    { type = "Delete" }
  }
}

resource "google_storage_bucket" "processed" {
  name     = var.proc_bucket_name
  location = var.location
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition { age = var.proc_lifecycle_age }
    action    { type = "Delete" }
  }
}
