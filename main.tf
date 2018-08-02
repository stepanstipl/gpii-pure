locals {
  name = "${replace(var.project, "/-[0-9]{4}$/", "")}"
}

module "cluster" {
  source = "./modules/cluster"

  name        = "${local.name}"
  region      = "${var.region}"
  k8s_version = "${var.k8s_version}"
  project     = "${var.project}"
}

#module "demo" {
#  source = "./modules/demo"
#  dep_on = ["${module.cluster.cluster_endpoint}", "${module.cluster.node_pool_node_count}"]
#}
