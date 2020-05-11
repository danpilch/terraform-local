variable "aws_config" {
  type = object({
    region = string
  })
}

variable "s3_tfstate" {
  type = object({
    bucket         = string
    dynamodb_table = string
  })
}
