.PHONY: admin-init
.DEFAULT_GOAL := help

help:                     ## Prints list of tasks
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z0-9_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' Makefile

admin-init:               ## Initialize TF (only run once)
	# Authenticate as a user
	gcloud auth application-default login --no-launch-browser
	# Disable remote state
	mv admin/state.tf{,.bak}
	# Initialize TF
	terraform init admin/
	# Apply TF
	terraform apply -input=false -auto-approve -target=module.org-root -target=module.project-root admin/
	# Enable remote state
	mv admin/state.tf{.bak,}
	# Initialize remote state
	terraform init -backend-config="bucket=$$(terraform output -module project-root -json | jq ".storage_bucket_name.value" -r)" -force-copy admin/

admin-apply:              ## Apply admin - manage projects 
	terraform apply -input=false -auto-approve admin/

admin-get-service-key:    ## Prints service account private key (json)
	terraform output -module project-root service_account_private_key
