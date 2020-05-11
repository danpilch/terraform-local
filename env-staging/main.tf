provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "dp-org-tf-state"
    key    = "terraform/workspaces/stage/terraform.tfstate"
    region = "eu-west-1"

    dynamodb_table = "dp-org-tf-state-table"
    encrypt        = true
  }
}
