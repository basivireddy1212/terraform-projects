gcloud auth login

gcloud auth application-default login

terraform init -backend-config=env/dev/backend.cfg

terraform plan -var-file=env/dev/terraform.tfvars


terraform init
terraform apply -var="project_id=your-project-id" -var="blue=1" -var="green=0"


