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
