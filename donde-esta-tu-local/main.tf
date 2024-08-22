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
  }
}

data "sops_file" "extra_secrets" {
  source_file = "extra-secrets.enc.json"
  input_type  = "json"
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

  extra_secrets = {
    JWK = data.sops_file.extra_secrets.data["JWK"]
  }
}
