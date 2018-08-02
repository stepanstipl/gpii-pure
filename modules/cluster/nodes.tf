resource "google_container_node_pool" "primary" {
  name    = "${var.name}-primary"
  region  = "${var.region}"
  cluster = "${google_container_cluster.this.name}"

  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  initial_node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    disk_size_gb = 100
    disk_type    = "pd-standard"
    image_type   = ""
    machine_type = "n1-standard-1"

    oauth_scopes = [
      "compute-rw",
      "storage-ro",
      "logging-write",
      "monitoring",
    ]

    preemptible = false

    workload_metadata_config {
      node_metadata = "SECURE"
    }
  }

  project = "${var.project}"
}
