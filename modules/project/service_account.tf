resource "google_service_account" "this" {
  count        = "${var.create_service_account ? 1 : 0}"
  account_id   = "default"
  display_name = "Service account for ${google_project.this.name}"
  project      = "${google_project.this.project_id}"
}

resource "google_service_account_key" "this" {
  count              = "${var.create_service_account ? 1 : 0}"
  service_account_id = "${element(google_service_account.this.*.name, count.index)}"
  key_algorithm      = "KEY_ALG_RSA_2048"
  public_key_type    = "TYPE_X509_PEM_FILE"
}
