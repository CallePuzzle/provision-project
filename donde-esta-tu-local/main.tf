terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "provision-project"

    workspaces {
      name = "donde-esta-tu-local"
    }
  }
}

module "this" {
  source = "../000-module"

  name        = "donde-esta-tu-local"
  app_url     = "https://donde-esta-tu-local.callepuzzle-rkjp.workers.dev"
  description = "Aplicación para saber donde están las peñas de tu pueblo"

  cloudflare_account_id = "173bf7921f79923475ce95a48b845583"
  enable_d1_database    = true
  enable_auth0          = true
}
