terraform {
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "tf_state_backend" {
  source     = "./modules/tf_state_backend"
  s3_tfstate = var.s3_tfstate
}
