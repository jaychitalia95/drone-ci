variable "location" {
    default = "us-east1"
}

variable "db_name" {
    default = "max"
}

variable "zone" {
    default = "us-east1-c"
}

variable "db_version" {
    default = "POSTGRES_12"
}

variable "project" {
    default = "gke-base-291019"
}

variable "machine_type" {
    default = "db-f1-micro"
}
