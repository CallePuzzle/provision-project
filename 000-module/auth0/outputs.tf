output "auth0_client_id" {
  value = auth0_client.this.client_id
}

output "auth0_client_secret" {
  value = auth0_client_credentials.this.client_secret
}