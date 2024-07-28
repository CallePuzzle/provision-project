data "cloudflare_user" "me" {
  count = var.is_template ? 0 : 1
}
data "cloudflare_api_token_permission_groups" "all" {
  count = var.is_template ? 0 : 1
}

# Token allowed to edit DNS entries and TLS certs for specific zone.
resource "cloudflare_api_token" "deploy_worker" {
  count = var.is_template ? 0 : 1

  name = "${var.name}_deploy_worker"

  // Listado de permisos sacados de la template de Edit Cloudflare Workers
  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all[0].account["Workers Scripts Write"],
      data.cloudflare_api_token_permission_groups.all[0].account["Workers KV Storage Write"],
      data.cloudflare_api_token_permission_groups.all[0].account["Account Settings Read"],
      data.cloudflare_api_token_permission_groups.all[0].account["Workers Tail Read"],
      data.cloudflare_api_token_permission_groups.all[0].account["Workers R2 Storage Write"],
      data.cloudflare_api_token_permission_groups.all[0].account["Pages Write"],
      data.cloudflare_api_token_permission_groups.all[0].account["D1 Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all[0].zone["Workers Routes Write"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.*" = "*"
    }
  }

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all[0].user["User Details Read"],
      data.cloudflare_api_token_permission_groups.all[0].user["Memberships Read"],
    ]
    resources = {
      "com.cloudflare.api.user.${data.cloudflare_user.me[0].id}" = "*",
    }
  }
}

resource "cloudflare_d1_database" "this" {
  count = var.enable_d1_database ? 1 : 0

  account_id = var.cloudflare_account_id
  name       = var.name
}
