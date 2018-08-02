resource "google_container_cluster" "this" {
  name   = "${var.name}"
  region = "${var.region}"

  addons_config {
    kubernetes_dashboard {
      disabled = true
    }
  }

  description = "${var.name} Cluster"

  ip_allocation_policy = {
    cluster_secondary_range_name  = "${var.name}-cluster-pods"
    services_secondary_range_name = "${var.name}-cluster-services"
  }

  logging_service = "logging.googleapis.com/kubernetes"

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  min_master_version = "${var.k8s_version}"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  network            = "projects/${google_compute_network.this.project}/global/networks/${google_compute_network.this.name}"
  subnetwork         = "projects/${google_compute_subnetwork.this.project}/regions/${google_compute_subnetwork.this.region}/subnetworks/${google_compute_subnetwork.this.name}"

  network_policy {
    enabled = true
  }

  node_pool {
    name       = "default-pool"
    node_count = 0
  }

  node_version = "${var.k8s_version}"

  pod_security_policy_config = {
    enabled = false
  }

  project = "${var.project}"

  remove_default_node_pool = true

  lifecycle {
    ignore_changes = ["node_pool"]
  }
}
