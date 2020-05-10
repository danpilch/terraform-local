aws_config = {
  region = "eu-west-1"
}

s3_tfstate = {
  bucket              = "dp-org-tf-state"
  dynamodb_table_name = "dp-org-tf-state-table"
  region              = "eu-west-1"
}

