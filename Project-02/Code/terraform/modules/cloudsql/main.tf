resource "google_sql_database_instance" "instance" {
  name             = var.instance_name
  region           = var.region
  project          = var.project_id
  database_version = var.database_version

  settings {
    tier = var.tier
    backup_configuration {
      enabled = true
    }
  }
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "user" {
  name     = var.db_user
  instance = google_sql_database_instance.instance.name
  password = var.db_password
}
