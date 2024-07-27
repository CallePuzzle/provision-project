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
  description = "Aplicación para saber donde están las peñas de tu pueblo"

  cloudflare_account_id = "173bf7921f79923475ce95a48b845583"
  altas_org_id          = "63124a91010508091918e063"
}

output "mongo_uri" {
  value     = module.this.mongo_uri
  sensitive = true
}
