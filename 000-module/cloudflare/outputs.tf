output "deploy_worker_cloudflare_api_token" {
  value = cloudflare_api_token.deploy_worker.value
}

output "d1_database_id" {
  value = var.enable_d1_database ? cloudflare_d1_database.this.id : null
}