variable "name" {
  description = "The name of the repository"
  type        = string
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