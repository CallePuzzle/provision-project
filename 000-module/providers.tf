terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.2.3"
    }
    cloudflare = {
      source                = "cloudflare/cloudflare"
      version               = "4.40.0"
      configuration_aliases = [cloudflare.staging]
    }
    auth0 = {
      source                = "auth0/auth0"
      version               = "1.4.0"
      configuration_aliases = [auth0.staging]
    }
  }
}
