terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "provision-project"

    workspaces {
      name = "y-tu-que-compras"
    }
  }

  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.1.1"
    }
    github = {
      source  = "integrations/github"
      version = "6.2.3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.40.0"
    }
    auth0 = {
      source  = "auth0/auth0"
      version = "1.4.0"
    }
  }
}

data "sops_file" "extra_secrets" {
  source_file = "extra-secrets.enc.json"
  input_type  = "json"
}

data "sops_file" "credentials" {
  source_file = "credentials.enc.json"
  input_type  = "json"
}

provider "github" {
  token = data.sops_file.credentials.data["GITHUB_TOKEN"]
  owner = data.sops_file.credentials.data["GITHUB_OWNER"]
}

provider "cloudflare" {
  api_token = data.sops_file.credentials.data["CLOUDFLARE_API_TOKEN"]
}

variable "auth0_api_token" {
  type        = string
  description = "API token for Auth0"
}

provider "auth0" {
  domain    = data.sops_file.credentials.data["AUTH0_DOMAIN"]
  api_token = var.auth0_api_token
}


module "this" {
  source = "../000-module"

  name         = "y-tu-que-compras"
  app_url      = "https://compras.callepuzzle.com"
  description  = "Aplicación para gestionar tus compras en el mercado"
  has_projects = true

  enable_d1_database    = true
  enable_auth0          = true
  cloudflare_account_id = "173bf7921f79923475ce95a48b845583"
  auth0_domain          = "https://${data.sops_file.credentials.data["AUTH0_DOMAIN"]}"

  extra_secrets = {
    JWK = data.sops_file.extra_secrets.data["JWK"]
  }

  providers = {
    cloudflare         = cloudflare
    cloudflare.staging = cloudflare
    auth0              = auth0
    auth0.staging      = auth0
    github             = github
  }
}

output "env" {
  value     = module.this.env
  sensitive = true
}

output "extra_secrets" {
  value     = module.this.extra_secrets
  sensitive = true
}
