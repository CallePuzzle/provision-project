resource "github_repository" "this" {
  name                        = var.name
  description                 = var.description
  visibility                  = var.visibility
  has_issues                  = var.has_issues
  has_discussions             = var.has_discussions
  has_projects                = var.has_projects
  has_wiki                    = var.has_wiki
  has_downloads               = var.has_downloads
  is_template                 = var.is_template
  allow_merge_commit          = var.allow_merge_commit
  allow_squash_merge          = var.allow_squash_merge
  allow_rebase_merge          = var.allow_rebase_merge
  squash_merge_commit_title   = var.squash_merge_commit_title
  squash_merge_commit_message = var.squash_merge_commit_message
  delete_branch_on_merge      = var.delete_branch_on_merge

  dynamic "template" {
    for_each = var.is_svelte_app && !var.is_template ? [1] : []
    content {
      owner      = "CallePuzzle"
      repository = "svelte-cloudflare-template"
    }

  }
}

resource "github_repository_file" "wrangler_toml" {
  repository = github_repository.this.name
  branch     = "main"
  file       = "wrangler.toml"
  content = templatefile("${path.module}/files/wrangler.toml.tftpl", {
    name                  = github_repository.this.name
    cloudflare_account_id = var.cloudflare_account_id
    enable_d1_database    = var.enable_d1_database
    d1_databases          = var.enable_d1_database ? cloudflare_d1_database.this : null
  })
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

resource "github_actions_secret" "deploy_worker" {
  count = var.is_template ? 0 : 1

  repository      = github_repository.this.name
  secret_name     = "CLOUDFLARE_API_TOKEN"
  plaintext_value = cloudflare_api_token.deploy_worker[0].value
}

resource "github_actions_secret" "auth0_client_id" {
  count = var.enable_auth0 ? 1 : 0

  repository      = github_repository.this.name
  secret_name     = "AUTH0_CLIENT_ID"
  plaintext_value = auth0_client.this[0].client_id
}

resource "github_actions_secret" "auth0_client_secret" {
  count = var.enable_auth0 ? 1 : 0

  repository      = github_repository.this.name
  secret_name     = "AUTH0_CLIENT_SECRET"
  plaintext_value = auth0_client_credentials.this[0].client_secret
}

resource "github_actions_secret" "extra" {
  for_each = var.extra_secrets

  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = each.value
}

locals {
  env_vars_d1       = var.enable_d1_database ? ["DATABASE_URL"] : []
  env_vars_auth0    = var.enable_auth0 ? ["AUTH0_DOMAIN", "AUTH0_CLIENT_ID", "AUTH0_CLIENT_SECRET"] : []
  env_extra_secrets = keys(var.extra_secrets)
}

resource "github_repository_file" "workflow_deploy" {
  repository = github_repository.this.name
  branch     = "main"
  file       = ".github/workflows/deploy.yaml"
  content = templatefile("${path.module}/files/deploy.yaml.tftpl", {
    wrangler_version   = "3.63.1"
    app_url            = var.app_url
    enable_d1_database = var.enable_d1_database
    enable_auth0       = var.enable_auth0
    extra_secrets      = var.extra_secrets
    variables_names    = join(",", concat(local.env_vars_d1, local.env_vars_auth0, local.env_extra_secrets))
  })
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true

  depends_on = [github_repository_file.wrangler_toml, github_actions_secret.deploy_worker]
}