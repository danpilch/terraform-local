#!/bin/bash

# Bootstrap terraform state bucket&dynamo table (chicken&egg issue)

# Vars
AWS_REGION="eu-west-1"
BUCKET_NAME="dp-org-tf-state"
STATE_PATH="global/s3/terraform-state"
DYNAMODB_TABLE_NAME="dp-org-tf-state-table"

# Create S3 bucket
aws s3api create-bucket \
    --bucket ${BUCKET_NAME} \
    --acl private \
    --create-bucket-configuration LocationConstraint=${AWS_REGION} \
    --region ${AWS_REGION}

# Use encryption by default 
aws s3api put-bucket-encryption \
    --bucket ${BUCKET_NAME} \
    --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'

# Enable object versioning by default
aws s3api put-bucket-versioning --bucket ${BUCKET_NAME} --versioning-configuration Status=Enabled

# Create tfvars
cat > terraform.tfvars << EOL
aws_config = {
  region = "${AWS_REGION}"
}

s3_tfstate = {
  bucket = "${BUCKET_NAME}"
  dynamodb_table_name = "${DYNAMODB_TABLE_NAME}"
  region = "${AWS_REGION}"
}

EOL

# Format newly created files
terraform fmt

# Initialise new backend
terraform init \
    -reconfigure \
    -backend-config="bucket="${BUCKET_NAME}"" \
    -backend-config="key="${STATE_PATH}"" \
    -backend-config="region="${AWS_REGION}"" \
    -backend-config="dynamodb_table="${DYNAMODB_TABLE_NAME}"" 

# Import new S3 bucket into terraform state
terraform import -lock=false module.tf_state_backend.aws_s3_bucket.tfstate_bucket ${BUCKET_NAME}

# Apply state to create dynamodb table
terraform apply -lock=false
