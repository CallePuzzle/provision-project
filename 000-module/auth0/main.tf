locals {
  develop_urls = [
    "http://localhost:8787",
    "http://localhost:5173",
  ]
}

resource "auth0_client" "this" {
  count = var.enable_auth0 ? 1 : 0

  name                = var.name
  description         = "Auth0 client for ${var.name}"
  app_type            = "regular_web"
  callbacks           = concat(["${var.app_url}/login/callback"], [for url in local.develop_urls : "${url}/login/callback"])
  allowed_origins     = concat([var.app_url], local.develop_urls)
  allowed_logout_urls = concat(["${var.app_url}/logout"], [for url in local.develop_urls : "${url}/logout"])
  web_origins         = concat([var.app_url], local.develop_urls)
  grant_types = [
    "authorization_code",
    "implicit",
    "refresh_token"
  ]
}

resource "auth0_client_credentials" "this" {
  count = var.enable_auth0 ? 1 : 0

  client_id             = auth0_client.this[0].client_id
  authentication_method = "client_secret_basic"
}
