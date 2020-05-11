provider "aws" {
  region = "eu-west-1"
}

module "tf_state_backend" {
  source     = "./modules/tf_state_backend"
  s3_tfstate = var.s3_tfstate
}

terraform {
  backend "s3" {
    bucket = "dp-org-tf-state"
    key    = "terraform/workspaces/default/terraform.tfstate"
    region = "eu-west-1"

    dynamodb_table = "dp-org-tf-state-table"
    encrypt        = true
  }
}

