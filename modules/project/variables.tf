variable "name" {
  description = "Project name"
  type        = "string"
}

variable "owners" {
  description = "Project owner (type:google_email_id)"
  default     = []
}

variable "billing_account" {
  description = "Project's billing account"
  type        = "string"
}

variable "org_id" {
  description = "Organization id"
  type        = "string"
}

variable "create_service_account" {
  description = "Whether to create service account for the project"
  default     = false
}

variable "create_ns_record" {
  description = "Whether to create DNS NS record in parent zone"
  default     = true
}

variable "location" {
  description = "Location of the project and it's GCS bucket"
  type        = "string"
}

variable "parent_dns_zone_name" {
  description = "Parent DNS zone name"
  default     = ""
}

variable "parent_dns_name" {
  description = "Parent DNS zone name"
  default     = ""
}

variable "parent_dns_project" {
  description = "Parent DNS project id"
  default     = ""
}
