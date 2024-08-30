terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "provision-project"

    workspaces {
      name = "donde-esta-tu-local"
    }
  }

  required_providers {
    sops = {
      source  = "carlpett/sops"
      version = "1.1.1"
    }
    github = {
      source  = "integrations/github"
      version = "6.2.2"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.35.0"
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

provider "auth0" {
  domain = data.sops_file.credentials.data["AUTH0_DOMAIN"]
  # token from AUTH0_API_TOKEN in .env file
}

module "this" {
  source = "../000-module"

  name         = "donde-esta-tu-local"
  app_url      = "https://donde-esta-tu-local.callepuzzle-rkjp.workers.dev"
  description  = "Aplicación para saber donde están las peñas de tu pueblo"
  has_projects = true

  cloudflare_account_id = "173bf7921f79923475ce95a48b845583"
  enable_d1_database    = true
  enable_auth0          = true

  environments = {
    staging = {
      name = "-staging"
    }
    main = {
        name = ""
    }
  }

  extra_secrets = {
    JWK = data.sops_file.extra_secrets.data["JWK"]
  }
}
