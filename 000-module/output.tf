output "mongo_uri" {
  value = var.altas_org_id != null ? local.mongo_uri : null
  sensitive = true
}