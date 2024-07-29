resource "auth0_client" "this" {
  count = var.enable_auth0 ? 1 : 0

  name                = var.name
  description         = "Auth0 client for ${var.name}"
  app_type            = "regular_web"
  callbacks           = ["http://localhost:8787/login/callback", "${var.app_url}/login/callback"]
  allowed_origins     = ["http://localhost:8787", var.app_url]
  allowed_logout_urls = ["http://localhost:8787/logout", "${var.app_url}/logout"]
  web_origins         = ["http://localhost:8787", var.app_url]
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
