resource "google_compute_network" "this" {
  name                    = "${var.name}-gke"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  project                 = "${var.project}"
}

resource "google_compute_subnetwork" "this" {
  name          = "${var.name}-default"
  ip_cidr_range = "10.128.0.0/20"
  region        = "${var.region}"
  network       = "${google_compute_network.this.self_link}"
  project       = "${var.project}"

  secondary_ip_range {
    range_name    = "${var.name}-cluster-pods"
    ip_cidr_range = "10.32.0.0/14"
  }

  secondary_ip_range {
    range_name    = "${var.name}-cluster-services"
    ip_cidr_range = "10.36.0.0/20"
  }
}
