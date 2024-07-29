terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.2.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.35.0"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.17.4"
    }
    auth0 = {
      source  = "auth0/auth0"
      version = "1.4.0"
    }
  }
}
