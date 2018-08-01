resource "random_string" "id" {
  length      = 4
  min_numeric = 4
}

resource "google_project" "this" {
  name            = "${var.name}"
  project_id      = "${var.name}-${random_string.id.result}"
  org_id          = "${var.org_id}"
  billing_account = "${var.billing_account}"
}

resource "google_project_services" "this" {
  project = "${google_project.this.project_id}"

  services = [
    "cloudbilling.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "dns.googleapis.com",
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
    "storage-api.googleapis.com",
  ]
}
