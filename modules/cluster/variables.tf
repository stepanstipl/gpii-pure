variable "name" {
  description = "Project name"
  type        = "string"
}

variable "region" {
  description = "Cluster region"
  type        = "string"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = "string"
}

variable "project" {
  description = "Project to use"
  type        = "string"
}
