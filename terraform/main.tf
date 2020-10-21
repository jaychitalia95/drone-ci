terraform {
  required_providers {
    sops = {
      source = "carlpett/sops"
      version = "0.5.2"
    }
  }
}

provider "sops" {}

provider "google" {
    project = var.project
    region = var.location
    zone = var.zone
}


data "sops_file" "secret" {
  source_file = "./local/secret.json"
}

resource "google_sql_database" "database" {
  name     = "${var.db_name}-db"
  instance = google_sql_database_instance.db_instance.name
}

resource "google_sql_database_instance" "db_instance" {
  name             = "${var.db_name}-dbinstance"
  database_version = var.db_version
  region           = var.location

  settings {
    tier = "db-f1-micro"
    availability_type = "ZONAL"
    # disk_size = 10
    ip_configuration {
      ipv4_enabled = true
    }
  }
}

resource "google_sql_user" "user" {
  name = data.sops_file.secret.data["username"]
  password = data.sops_file.secret.data["password"]
  instance = google_sql_database_instance.db_instance.name
}