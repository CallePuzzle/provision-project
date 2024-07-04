# Zone permissions
data "cloudflare_api_token_permission_groups" "all" {
  count = var.is_template ? 0 : 1
}

# Token allowed to edit DNS entries and TLS certs for specific zone.
resource "cloudflare_api_token" "deploy_worker" {
  count = var.is_template ? 0 : 1

  name = "${var.name}_deploy_worker"

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all[0].account["Workers Scripts Read"],
      data.cloudflare_api_token_permission_groups.all[0].account["Workers Scripts Write"],
      data.cloudflare_api_token_permission_groups.all[0].account["Workers KV Storage Read"],
      data.cloudflare_api_token_permission_groups.all[0].account["Workers KV Storage Write"],
      data.cloudflare_api_token_permission_groups.all[0].account["Workers R2 Storage Read"],
      data.cloudflare_api_token_permission_groups.all[0].account["Workers R2 Storage Write"],
      data.cloudflare_api_token_permission_groups.all[0].zone["Workers Routes Read"],
      data.cloudflare_api_token_permission_groups.all[0].zone["Workers Routes Write"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.${var.cloudflare_zone_id}" = "*"
    }
  }
}