variable "region" {
  description = "Cluster region"
  type        = "string"
}

variable "k8s_version" {
  description = "Kubernetes version"
  default     = "1.10.5-gke.3"
}

variable "project" {
  description = "Project to use"
  type        = "string"
}
