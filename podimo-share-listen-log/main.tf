terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "provision-project"

    workspaces {
      name = "podimo-share-listen-log"
    }
  }
}

module "this" {
  source = "../000-module"

  name        = "podimo-share-listen-log"
  description = "Podimo Share Listen Log allows users to effortlessly share their podcast listening history with friends"
  
  cloudflare_account_id = "173bf7921f79923475ce95a48b845583"
}