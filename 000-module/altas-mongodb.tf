resource "mongodbatlas_project" "this" {
  count = var.altas_org_id != null ? 1 : 0

  name   = var.name
  org_id = var.altas_org_id
}

resource "mongodbatlas_cluster" "this" {
  count = var.altas_org_id != null ? 1 : 0

  project_id = mongodbatlas_project.this[0].id
  name       = "${var.name}-mongodb"

  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "EU_WEST_1"
  provider_instance_size_name = "M0"
}

resource "random_password" "this" {
  count = var.altas_org_id != null ? 1 : 0

  length  = 16
  special = false
}

resource "mongodbatlas_database_user" "this" {
  count = var.altas_org_id != null ? 1 : 0

  project_id         = mongodbatlas_project.this[0].id
  username           = var.name
  password           = random_password.this[0].result
  auth_database_name = "admin"

  roles {
    database_name = "admin"
    role_name     = "readWriteAnyDatabase"
  }

  scopes {
    name = "${var.name}-mongodb"
    type = "CLUSTER"
  }
}

resource "mongodbatlas_project_ip_access_list" "this" {
  project_id = mongodbatlas_project.this[0].id
  cidr_block = "0.0.0.0/0"
  comment    = var.name
}