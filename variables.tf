variable "aws_config" {
  type = object({
    region = string
  })
  default = {
    region = "eu-west-1"
  }
}

variable "s3_tfstate" {
  type = object({
    bucket         = string
    dynamodb_table = string
    base_state_key = string
  })
  default = {
    bucket         = "dp-org-tf-state"
    dynamodb_table = "dp-org-tf-state-table"
    base_state_key = "terraform/workspaces/default/terraform.tfstate"
  }
}
