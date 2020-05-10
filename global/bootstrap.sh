#!/bin/bash

# Bootstrap terraform state bucket&dynamo table (chicken&egg issue)

# Vars
AWS_REGION="eu-west-1"
BUCKET_NAME="dp-org-tf-state-2"
TF_ENV="default"
STATE_PATH="terraform/workspaces/$TF_ENV/terraform.tfstate"
DYNAMODB_TABLE="dp-org-tf-state-table-2"

# Create initial main.tf
cat > main.tf << EOL
provider "aws" {
  region = "${AWS_REGION}"
}

module "tf_state_backend" {
  source     = "../modules/tf_state_backend"
  s3_tfstate = var.s3_tfstate
}

EOL

# local init
terraform init

# plan bootstrap
terraform plan

# apply bootstrap
terraform apply

# Update main.tf to add new s3 backend
cat >> main.tf << EOL
terraform {
  backend "s3" {
    bucket = "${BUCKET_NAME}"
    key = "${STATE_PATH}"
    region = "${AWS_REGION}"

    dynamodb_table = "${DYNAMODB_TABLE}"
    encrypt = true
  }
}
    
EOL

# Create tfvars
cat > terraform.tfvars << EOL
aws_config = {
  region = "${AWS_REGION}"
}

s3_tfstate = {
  bucket = "${BUCKET_NAME}"
  dynamodb_table = "${DYNAMODB_TABLE}"
}

EOL

# Format newly created files
terraform fmt

# Reconfigure backend to use remote state
terraform init -reconfigure 

# Import new S3 bucket into terraform state
#terraform import -lock=false module.tf_state_backend.aws_s3_bucket.tfstate_bucket ${BUCKET_NAME}

# Apply state to create dynamodb table
#terraform apply -lock=false
