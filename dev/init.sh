#!/bin/bash

# Usage: ./init.sh once to initialize remote storage for this environment.
# Subsequent tf actions in this environment don't require re-initialization, 
# unless you have completely cleared your .terraform cache.
#
# terraform plan  -var-file=./development.tfvars 
# terraform apply -var-file=./development.tfvars 

tf_env="development"
tf_s3_bucket="dp-org-tf-state"
tf_aws_region="eu-west-1"
dynamodb_table="dp-org-tf-state-table"

terraform init -backend=true \
    -backend-config="backend=s3" \
    -backend-config="bucket=$tf_s3_bucket" \
    -backend-config="key=$tf_env.tfstate" \
    -backend-config="dynamodb_table=$dynamodb_table" \
    -backend-config="region=$tf_aws_region"

echo "set remote s3 state to $tf_env.tfstate"
