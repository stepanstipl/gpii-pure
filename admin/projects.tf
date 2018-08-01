module "project-dev-test" {
  source = "../modules/project"

  billing_account      = "${var.billing_account}"
  location             = "${var.location}"
  name                 = "dev-test"
  org_id               = "${var.org_id}"
  parent_dns_zone_name = "${module.project-root.dns_zone_name}"
  parent_dns_project   = "${module.project-root.project_id}"
  owners               = ["user:test-01@stgca01.stipl.net"]
}

module "project-prod" {
  source = "../modules/project"

  billing_account        = "${var.billing_account}"
  location               = "${var.location}"
  name                   = "prod"
  org_id                 = "${var.org_id}"
  parent_dns_zone_name   = "${module.project-root.dns_zone_name}"
  parent_dns_project     = "${module.project-root.project_id}"
  owners                 = ["group:group-01@stgca01.stipl.net"]
  create_service_account = true
}
