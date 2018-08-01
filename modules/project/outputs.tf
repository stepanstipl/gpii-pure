output "storage_bucket_name" {
  value = "${google_storage_bucket.this.name}"
}

output "project_id" {
  value = "${google_project.this.id}"
}

output "service_account_email" {
  value = "${join("", google_service_account.this.*.email)}"
}

output "service_account_private_key" {
  value     = "${base64decode(join("", google_service_account_key.this.*.private_key))}"
  sensitive = true
}

output "dns_zone_name" {
  value = "${google_dns_managed_zone.this.name}"
}
