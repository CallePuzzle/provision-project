terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "provision-project"

    workspaces {
      name = "svelte-cloudflare-template"
    }
  }
}

module "this" {
  source = "../000-module"

  name        = "svelte-cloudflare-template"
  description = "Svelte Cloudflare Template"

  is_template = true
}
