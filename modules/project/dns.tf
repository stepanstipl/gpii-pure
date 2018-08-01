locals {
  parent_dns_name = "${var.create_ns_record ? join("", data.google_dns_managed_zone.parent.*.dns_name) : var.parent_dns_name}"
}

data "google_dns_managed_zone" "parent" {
  count   = "${var.create_ns_record ? 1 : 0}"
  name    = "${var.parent_dns_zone_name}"
  project = "${var.parent_dns_project}"
}

resource "google_dns_managed_zone" "this" {
  name        = "${google_project.this.project_id}-project-zone"
  dns_name    = "${var.name}.${local.parent_dns_name}"
  description = "Zone for ${google_project.this.project_id}"
  project     = "${google_project.this.project_id}"
  depends_on  = ["google_project_services.this"]
}

resource "google_dns_record_set" "ns" {
  count        = "${var.create_ns_record ? 1 : 0}"
  name         = "${var.name}.${local.parent_dns_name}"
  managed_zone = "${data.google_dns_managed_zone.parent.name}"
  type         = "NS"
  ttl          = 300
  project      = "${var.parent_dns_project}"

  rrdatas = ["${google_dns_managed_zone.this.name_servers}"]
}
