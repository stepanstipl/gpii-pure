resource "google_storage_bucket" "this" {
  name          = "${google_project.this.project_id}-infra"
  location      = "${var.location}"
  force_destroy = true
  project       = "${google_project.this.project_id}"
  storage_class = "MULTI_REGIONAL"

  versioning {
    enabled = true
  }
}
