gcloud auth login

gcloud auth application-default login
export GOOGLE_APPLICATION_CREDENTIALS=~/gcp-key.json
gcloud config list
gcloud projects list
terraform init -backend-config=env/dev/backend.cfg

terraform plan -var-file=env/dev/terraform.tfvars
