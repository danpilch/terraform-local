provider "aws" {
  region = var.aws_config.region
}

data "terraform_remote_state" "master_state" {
  backend = "s3"
  config = {
    region = var.aws_config.region
    bucket = var.s3_tfstate.bucket
    key    = var.s3_tfstate.base_state_key
  }
}

module "vpc" {
  source = "../modules/vpc"
}
