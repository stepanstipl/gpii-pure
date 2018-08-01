variable "org_id" {
  description = "Organization id"
  type        = "string"
}

variable "admin_members" {
  description = "Administrators of the organization (type:email_id)"
  type        = "list"
}

variable "billing_admin_members" {
  description = "Administrators of the organization (type:email_id)"
  type        = "list"
}
