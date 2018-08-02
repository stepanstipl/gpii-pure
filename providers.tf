provider "google" {
  version = "= 1.16.2"
  project = "prod-1068"
}

provider "random" {
  version = "= 1.3.1"
}

#provider "helm" {
#  version         = "= 0.5.1"
#  service_account = "tiller"
#}

provider "null" {
  version = "= 1.0.0"
}

provider "kubernetes" {
  version = "= 1.1.0"
}
