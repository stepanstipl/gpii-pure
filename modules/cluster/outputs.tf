output "cluster_endpoint" {
  value = "${google_container_cluster.this.endpoint}"
}

output "node_pool_node_count" {
  value = "${google_container_node_pool.primary.node_count}"
}
