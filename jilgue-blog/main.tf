terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "provision-project"

    workspaces {
      name = "jilgue-blog"
    }
  }
}

module "this" {
  source = "../000-module"

  name        = "blog"
  description = "Blog for dev.callepuzzle.com"

  cloudflare_zone_id = "d9dfcd07cb412c204a20b78e5bc06c37"
}