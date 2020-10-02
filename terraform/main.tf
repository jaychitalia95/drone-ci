provider "google" {
    project = var.project
    region = var.location
    zone = var.zone
}

resource "google_sql_database" "database" {
  name     = "${var.db_name}-db"
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_database_instance" "db_instance" {
  name             = "${var.db_name}-db-instance"
  database_version = var.db_version
  region           = var.location

  settings {
    tier = "db-f1-micro"
    availability_type = "ZONAL"
  }
}