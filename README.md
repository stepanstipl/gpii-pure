# gpii-pure

*Manage GCP & GKE infrastructure with Terraform only.*

This project uses pure Terraform and simple Make wrapper. All dependencies are
packaged as docker image and that's all you need.

## Directory tructure
```
/               - main TF code to create and manage clusters
|- admin        - TF code for project management
|- modules      - TF modules
  |- cluster       - module to create K8s cluster
  |- organization  - module to manage GCP organization
  |- project       - module to create GCP project
  |- demo          - module to demo app deployment via helm provider
```

## Make

Each command has it's `docker-` variant, such as `cluster-apply` and
`docker-cluster-apply`.

It can be run directly in docker
```
docker run -it --rm -e TF_VAR_project=dev-xyz-1234 gpii-pure cluster-apply
```
or if you have checked out the reposiotry and Makefile, you can use
```
TF_VAR_project=dev-xyz-1234 make docker-cluster-apply
```

Run `make help` to get list of available tasks.

## Use

### User- reate or update your Kubernetes cluster

`TF_VAR_project=dev-xyz-1234 cluster-apply`

### Admin

#### Manage projects

`TF_VAR_project=root-1234 make docker-admin-apply`

#### Init
This step should be run manually and only once. It will bring the whole GCP
organization under TF management.

`make docker-admin-init`

#### Prerequisites
- Setup Billing Account
- Set `billing_account`, `org_id`, `location`, `parent_dns_name`,
  `admin_members` and `billing_admin_members` variables (`admin/variables.tf`).
  (These will be set to corret ones by default)

#### Required permissions
- Organization Role Administrator
- Owner
- Organization Administrator
- Project Creator

## Design questions
- More than 1 cluster per project or 1:1?
- Accounts & groups structure

## TODO
- Consider removing default accounts from projects
- Consider using PGP
- Further investigate org iam policy permissions
- Clean-up billing account mess!
- Statefile backup left after upload to remote
- Bring svc account for node pool under TF mgmt
- Do not deploy Helm & Tiller via provider
- Auth - Support in & out docker workflows, user & service account, instance
- Enable pod secrity policy
- Possibly more services than we need for root project
- admin-destroy - fails obviously as the bucket is gone
