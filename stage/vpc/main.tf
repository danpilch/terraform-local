terraform {
  backend "s3" {
    encrypt = true
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "../../modules/vpc"
}  
