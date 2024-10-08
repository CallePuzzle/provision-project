locals {
  _secret_names_suffix = var.is_staging ? "_STAGING" : ""
}

resource "github_repository_file" "wrangler_toml" {
  count      = var.is_staging ? 0 : 1
  repository = var.repository
  branch     = "main"
  file       = "wrangler.toml"
  content = templatefile("${path.module}/files/wrangler.toml.tftpl", {
    name                          = var.repository
    cloudflare_account_id         = var.cloudflare_account_id
    staging_cloudflare_account_id = var.staging_cloudflare_account_id
    d1_database_id                = var.d1_database_id
    enable_staging_environment    = var.enable_staging_environment
    staging_d1_database_id        = var.staging_d1_database_id
  })
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

resource "github_actions_secret" "deploy_worker" {
  repository      = var.repository
  secret_name     = "CLOUDFLARE_API_TOKEN${local._secret_names_suffix}"
  plaintext_value = var.deploy_worker_cloudflare_api_token
}

resource "github_actions_secret" "auth0_domain" {
  count = var.enable_auth0 ? 1 : 0

  repository      = var.repository
  secret_name     = "AUTH0_DOMAIN${local._secret_names_suffix}"
  plaintext_value = var.auth0_domain
}

resource "github_actions_secret" "auth0_client_id" {
  count = var.enable_auth0 ? 1 : 0

  repository      = var.repository
  secret_name     = "AUTH0_CLIENT_ID${local._secret_names_suffix}"
  plaintext_value = var.auth0_client_id
}

resource "github_actions_secret" "auth0_client_secret" {
  count = var.enable_auth0 ? 1 : 0

  repository      = var.repository
  secret_name     = "AUTH0_CLIENT_SECRET${local._secret_names_suffix}"
  plaintext_value = var.auth0_client_secret
}

resource "github_actions_secret" "extra" {
  for_each = var.is_staging ? {} : var.extra_secrets

  repository      = var.repository
  secret_name     = each.key
  plaintext_value = each.value
}

locals {
  wrangler_version  = "3.74.0"
  env_vars_d1       = var.enable_d1_database ? ["DATABASE_URL"] : []
  env_vars_auth0    = var.enable_auth0 ? ["AUTH0_DOMAIN", "AUTH0_CLIENT_ID", "AUTH0_CLIENT_SECRET"] : []
  env_extra_secrets = keys(var.extra_secrets)
}

resource "github_repository_file" "workflow_deploy" {
  count      = var.is_staging ? 0 : 1
  repository = var.repository
  branch     = "main"
  file       = ".github/workflows/deploy-main.yaml"
  content = templatefile("${path.module}/files/deploy-main.yaml.tftpl", {
    name                = var.repository
    wrangler_version    = local.wrangler_version
    app_url             = var.app_url
    enable_d1_database  = var.enable_d1_database
    enable_auth0        = var.enable_auth0
    auth0_app_url       = var.auth0_app_url != null ? var.auth0_app_url : var.app_url
    extra_secrets_names = local.env_extra_secrets
    variables_names     = join(",", concat(local.env_vars_d1, local.env_vars_auth0, local.env_extra_secrets))
  })
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true

  depends_on = [github_repository_file.wrangler_toml, github_actions_secret.deploy_worker]
}

resource "github_repository_file" "workflow_deploy_staging" {
  count      = var.is_staging ? 1 : 0
  repository = var.repository
  branch     = "main"
  file       = ".github/workflows/deploy-pr.yaml"
  content = templatefile("${path.module}/files/deploy-pr.yaml.tftpl", {
    name                = var.repository
    wrangler_version    = local.wrangler_version
    app_url             = var.app_url
    enable_d1_database  = var.enable_d1_database
    enable_auth0        = var.enable_auth0
    auth0_app_url       = var.auth0_app_url != null ? var.auth0_app_url : var.app_url
    extra_secrets_names = local.env_extra_secrets
    variables_names     = join(",", concat(local.env_vars_d1, local.env_vars_auth0, local.env_extra_secrets))
  })
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true

  depends_on = [github_actions_secret.deploy_worker]
}