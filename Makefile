.PHONY: help admin-init admin-apply admin-get-service-key test test-lint cluster-apply auth auth-gke
.DEFAULT_GOAL := help
.ONESHELL :
SHELL = /bin/bash

DOCKER_IMAGE = gpii-pure
# Strip last part of project name dev-xyz-1234 -> dev-xyz
export CLUSTER_NAME ?= $(shell VAR="$(TF_VAR_project)"; echo $${VAR%-*})
export TF_VAR_region ?= europe-west2
export TF_VAR_location ?= eu

exp:
	export

help:                     ## Prints list of tasks
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' Makefile

admin-init: auth          ## Initialize TF (only run once)
	# Disable remote state
	mv admin/state.tf{,.bak}
	mv state.tf{,.bak}
	# Initialize TF
	terraform init admin/
	# Apply TF
	terraform apply -input=false -auto-approve -target=module.org-root -target=module.project-root admin/
	export BUCKET=$$(terraform output -module project-root -json | jq ".storage_bucket_name.value" -r)
	# Enable remote state
	mv admin/state.tf{.bak,}
	mv state.tf{.bak,}
	# Initialize remote state
	terraform init -backend-config="bucket=$${BUCKET}" -force-copy admin/

admin-apply: auth         ## Apply admin - manage projects 
	$(call check_vars, TF_VAR_project)
	terraform init -backend-config="bucket=$(TF_VAR_project)-infra" admin/
	terraform apply -input=false -auto-approve admin/

admin-plan: auth         ## Apply admin - manage projects 
	echo CHECK NOW
	$(call check_vars, TF_VAR_project)
	terraform init -backend-config="bucket=$(TF_VAR_project)-infra" admin/
	terraform plan -input=false admin/

admin-destroy: auth            ## Destroy everything
	$(call check_vars, TF_VAR_project)
	terraform init -backend-config="bucket=$(TF_VAR_project)-infra" admin/
	# This should really never be removed, it's protected in the plan
	terraform state rm module.org-root.google_organization_iam_policy.this
	terraform destroy -input=false -auto-approve admin/

admin-get-service-key:    ## Prints service account private key (json)
	@terraform output -module project-root service_account_private_key

test: test-lint           ## Runs all suite of tests

test-lint:                ## Runs terraform fmt check
	terraform fmt -check=true

cluster-apply: auth       ## Creates or updates cluster
	# Init terraform state
	terraform init -backend-config="bucket=$(TF_VAR_project)-infra"
	terraform apply -input=false -auto-approve -target=module.cluster

cluster-plan: auth auth-gke     ## Creates or updates cluster
	# Init terraform state
	terraform init -backend-config="bucket=$(TF_VAR_project)-infra"
	terraform plan -input=false

cluster-destroy: auth            ## Destroy cluster
	$(call check_vars, TF_VAR_project)
	terraform init -backend-config="bucket=$(TF_VAR_project)-infra"
	terraform destroy -input=false -auto-approve

auth:                            ## Login to GCP
	# Authenticate as a user
	gcloud projects list &> /dev/null || gcloud auth application-default login --no-launch-browser

auth-gke:                        ## Login to GKE
	$(call check_vars, TF_VAR_project)
	gcloud container clusters get-credentials $(CLUSTER_NAME) --region $(TF_VAR_region) --project $(TF_VAR_project) || true

check_vars = \
	  $(foreach var, $(1), $(if $(value $(strip $(var))),, $(error Variable $(var) is not set.)))

docker-%:
	docker run -it --rm -e TF_VAR_project $(DOCKER_IMAGE) $*

# Little helpers for Docker -> no need to change entrypoint
bash:
	bash

sh:
	sh
