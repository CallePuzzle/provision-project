data "cloudflare_user" "me" {}

data "cloudflare_api_token_permission_groups" "all" {}

# Token allowed to edit DNS entries and TLS certs for specific zone.
resource "cloudflare_api_token" "deploy_worker" {

  name = "${var.name}_deploy_worker"

  // Listado de permisos sacados de la template de Edit Cloudflare Workers
  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Workers Scripts Write"],
      data.cloudflare_api_token_permission_groups.all.account["Workers KV Storage Write"],
      data.cloudflare_api_token_permission_groups.all.account["Account Settings Read"],
      data.cloudflare_api_token_permission_groups.all.account["Workers Tail Read"],
      data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Write"],
      data.cloudflare_api_token_permission_groups.all.account["Pages Write"],
      data.cloudflare_api_token_permission_groups.all.account["D1 Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.zone["Workers Routes Write"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.*" = "*"
    }
  }

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.user["User Details Read"],
      data.cloudflare_api_token_permission_groups.all.user["Memberships Read"],
    ]
    resources = {
      "com.cloudflare.api.user.${data.cloudflare_user.me.id}" = "*",
    }
  }
}

resource "cloudflare_d1_database" "this" {
  account_id = var.cloudflare_account_id
  name       = var.name
}
