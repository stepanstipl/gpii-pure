resource "null_resource" "dep" {
  triggers {
    dep = "${join(",",var.dep_on)}"
  }

  # Try to get kubectl credentials
  provisioner "local-exec" {
    command = "make auth-gke"
  }
}

resource "kubernetes_service_account" "helm" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"
  }

  depends_on = ["null_resource.dep"]

  # Try to get kubectl credentials
  provisioner "local-exec" {
    command = "kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller"
  }
}

resource "helm_release" "dokuwiki" {
  name       = "dokuwiki"
  repository = "stable"
  chart      = "dokuwiki"

  depends_on = ["null_resource.dep", "kubernetes_service_account.helm"]
}
