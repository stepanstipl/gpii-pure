# This is dangerous - can lead to removing access to org
# Should never be destroyed as it removes all permission to org
# Update is fine, also can be saved by GSuite Super Admin
resource "google_organization_iam_policy" "this" {
  org_id      = "${var.org_id}"
  policy_data = "${data.google_iam_policy.this.policy_data}"

  lifecycle {
    prevent_destroy = true
  }
}

data "google_iam_policy" "this" {
  binding {
    role    = "roles/resourcemanager.organizationAdmin"
    members = ["${var.admin_members}"]
  }

  binding {
    role    = "roles/resourcemanager.projectCreator"
    members = ["${var.admin_members}"]
  }

  binding {
    role    = "roles/owner"
    members = ["${var.admin_members}"]
  }

  binding {
    role    = "roles/billing.user"
    members = ["${var.admin_members}"]
  }

  binding {
    role    = "roles/billing.admin"
    members = ["${var.billing_admin_members}"]
  }

  binding {
    role    = "roles/iam.organizationRoleAdmin"
    members = ["${var.admin_members}"]
  }
}
