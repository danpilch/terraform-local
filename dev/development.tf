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

module "iam" {
  source = "../modules/iam"
  iam_config = {
    environment = var.environment
    stack_name = join("-", ["iam", var.environment])
    iam_default_password = var.default_iam_password
  }
}

module "vpc" {
  source = "../modules/vpc"
}
