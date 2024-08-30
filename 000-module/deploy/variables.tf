variable "repository" {
  description = "The repository to deploy"
  type        = string
}

variable "app_url" {
  description = "The URL of the application"
  type        = string
  default     = null
}

variable "cloudflare_account_id" {
  description = "The Cloudflare Account ID"
  type        = string
  default     = null
}

variable "enable_d1_database" {
  description = "Whether to enable the D1 Database module"
  type        = bool
  default     = false
}

variable "d1_database_id" {
  description = "The D1 Database ID"
  type        = string
  default     = null
}

variable "enable_auth0" {
  description = "Whether to enable the Auth0 module"
  type        = bool
  default     = false
}

variable "deploy_worker_cloudflare_api_token" {
  description = "The Cloudflare API Token for the deploy worker"
  type        = string
}

variable "auth0_client_id" {
  description = "The Auth0 Client ID"
  type        = string
  default     = null
}

variable "auth0_client_secret" {
  description = "The Auth0 Client Secret"
  type        = string
  default     = null
}

variable "extra_secrets" {
  description = ""
  type        = map(string)
  default     = {}
}

