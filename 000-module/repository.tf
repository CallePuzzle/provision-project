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

locals {
  mongo_uri = replace(mongodbatlas_cluster.this[0].connection_strings[0].standard_srv, "mongodb+srv://", "mongodb+srv://${var.name}:${random_password.this[0].result}@")
}

resource "github_actions_secret" "mongo_uri" {
  count = var.altas_org_id != null ? 1 : 0

  repository      = github_repository.this.name
  secret_name     = "MONGO_URI"
  plaintext_value = local.mongo_uri
}

resource "github_repository_file" "workflow_deploy" {
  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/deploy.yaml"
  content             = file("${path.module}/files/deploy.yaml")
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true

  depends_on = [github_repository_file.wrangler_toml, github_actions_secret.deploy_worker]
}