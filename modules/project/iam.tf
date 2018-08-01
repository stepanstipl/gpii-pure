resource "google_project_iam_binding" "this" {
  project = "${google_project.this.project_id}"
  role    = "roles/owner"
  members = ["${var.owners}", "${formatlist("serviceAccount:%s", google_service_account.this.*.email)}"]
}
