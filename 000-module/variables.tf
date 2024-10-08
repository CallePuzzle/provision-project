variable "name" {
  description = "The name of the repository"
  type        = string
}

variable "app_url" {
  description = "The URL of the application"
  type        = string
  default     = null
}

variable "staging_app_url" {
  description = "The URL of the application"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the repository"
  type        = string
}

variable "visibility" {
  description = "The visibility of the repository"
  type        = string
  default     = "public"
}

variable "has_issues" {
  description = "Whether the repository has issues enabled"
  type        = bool
  default     = true
}

variable "has_discussions" {
  description = "Whether the repository has discussions enabled"
  type        = bool
  default     = false
}

variable "has_projects" {
  description = "Whether the repository has projects enabled"
  type        = bool
  default     = false
}

variable "has_wiki" {
  description = "Whether the repository has a wiki enabled"
  type        = bool
  default     = false
}

variable "has_downloads" {
  description = "Whether the repository has downloads enabled"
  type        = bool
  default     = false
}

variable "allow_merge_commit" {
  description = "Whether the repository allows merge commits"
  type        = bool
  default     = false
}

variable "allow_squash_merge" {
  description = "Whether the repository allows squash merges"
  type        = bool
  default     = true
}

variable "allow_rebase_merge" {
  description = "Whether the repository allows rebase merges"
  type        = bool
  default     = false
}

variable "squash_merge_commit_title" {
  description = "The title of the commit when squashing a merge"
  type        = string
  default     = "PR_TITLE"
}

variable "squash_merge_commit_message" {
  description = "The message of the commit when squashing a merge"
  type        = string
  default     = "COMMIT_MESSAGES"
}

variable "delete_branch_on_merge" {
  description = "Whether to delete the branch on merge"
  type        = bool
  default     = true
}

variable "is_template" {
  description = "Whether the repository is a template"
  type        = bool
  default     = false
}

variable "is_svelte_app" {
  description = "Whether the repository is a Svelte app"
  type        = bool
  default     = true
}

variable "extra_secrets" {
  description = ""
  type        = map(string)
  default     = {}
}

variable "enable_staging_environment" {
  description = "Whether to enable the staging environment"
  type        = bool
  default     = false
}

/*
 * Cloudflare
 */
variable "cloudflare_account_id" {
  description = "The Cloudflare Account ID"
  type        = string
  default     = null
}

variable "staging_cloudflare_account_id" {
  description = "The Cloudflare Account ID for the staging environment"
  type        = string
  default     = null
}

variable "enable_d1_database" {
  description = "Whether to enable the D1 Database module"
  type        = bool
  default     = false
}

/*
 * Atlas MongoDB
 */
variable "enable_mongodbatlas" {
  description = "Whether to enable the Atlas MongoDB module"
  type        = bool
  default     = false
}

variable "altas_org_id" {
  description = "The Atlas MongoDB Organization ID"
  type        = string
  default     = null
}

/*
 * Auth0
 */
variable "enable_auth0" {
  description = "Whether to enable the Auth0 module"
  type        = bool
  default     = false
}

variable "auth0_domain" {
  description = "The Auth0 domain"
  type        = string
  default     = null
}

variable "auth0_app_url" {
  description = "The URL of the Auth0 application"
  type        = string
  default     = null
}

variable "staging_auth0_domain" {
  description = "The Auth0 domain for the staging environment"
  type        = string
  default     = null
}

variable "auth0_app_url_staging" {
  description = "The URL of the Auth0 application for the staging environment"
  type        = string
  default     = null
}