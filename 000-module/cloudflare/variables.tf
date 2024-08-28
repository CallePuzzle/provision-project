variable "name" {
    type = string
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