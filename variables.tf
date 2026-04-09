variable "github_owner" {
  description = "GitHub user or organization that owns the managed repositories. Leave null to use the authenticated user."
  type        = string
  default     = null
}

variable "manage_organization_resources" {
  description = "Enable organization-only resources such as teams and organization members."
  type        = bool
  default     = false
}