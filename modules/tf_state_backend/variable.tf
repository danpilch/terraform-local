variable "s3_tfstate" {
  type = object({
    bucket              = string
    dynamodb_table_name = string
  })
}
