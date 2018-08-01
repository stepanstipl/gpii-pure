## Notes

- Setup Billing Account

### Required permissions
- Organization Role Administrator
- Owner
- Organization Administrator
- Project Creator



- gcloud alpha billing accounts get-iam-policy 016DD8-4901EE-5F96BD add root as
  billing account user

- gcloud auth application-default login --no-launch-browser

- gcloud iam service-accounts keys list --iam-account root-ci@root-project-123.iam.gserviceaccount.com

-> create key.json - will have to be passed to CI somehow..

- gcloud auth activate-service-account root-ci@root-project-123.iam.gserviceaccount.com --key-file root-ci.key.json

- terraform init -backend-config="bucket=root-project-123-tf-state"

- terraform init -backend-config="bucket=root-project-123-tf-state" -force-copy
terraform output -module project-root -json | jq ".storage_bucket_name.value" -r

/Users/stepan/.config/gcloud/application_default_credentials.json
- terraform init -input=false -backend=false
- terraform output -module project-root -json | jq ".service_account_private_key.value" -r


## Design questions
- More than 1 cluster per project or 1:1?
- Groups
  -  1 owner of the project -> group for shared, user for individual
  -  

## TODO

- Consider removing default accounts from projects
- Consider using PGP
- Generate random project ids (delete issue)
- Further investigate org iam policy permissions
- Clean-up billing account mess!
