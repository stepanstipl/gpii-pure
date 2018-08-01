# Root project
module "project-root" {
  source = "../modules/project"

  billing_account        = "${var.billing_account}"
  location               = "${var.location}"
  name                   = "root"
  org_id                 = "${var.org_id}"
  create_service_account = true
  create_ns_record       = false
  parent_dns_name        = "${var.parent_dns_name}"
}

module "org-root" {
  source = "../modules/organization"

  org_id                = "${var.org_id}"
  admin_members         = ["${var.admin_members}", "serviceAccount:${module.project-root.service_account_email}"]
  billing_admin_members = ["${var.billing_admin_members}"]
}
