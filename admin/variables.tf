variable "billing_account" {
  description = "Project's billing account"
  default     = "016DD8-4901EE-5F96BD"
}

variable "org_id" {
  description = "Organization id"
  default     = "149862983804"
}

variable "location" {
  description = "Location of the project and it's GCS bucket"
  default     = "US"
}

variable "parent_dns_name" {
  description = "Parent DNS name for everything"
  default     = "stgca01.stipl.net."
}

variable "admin_members" {
  description = "Administrators of the organization (type:email_id)"
  default     = ["user:stepan@stgca01.stipl.net"]
}

variable "billing_admin_members" {
  description = "Billing Administrators of the organization (type:email_id)"
  default     = ["user:stepan@stgca01.stipl.net"]
}
