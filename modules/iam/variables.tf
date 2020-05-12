variable "iam_config" {
  type = object({
    stack_name           = string
    environment          = string
    iam_default_password = string
  })
  default = {
    stack_name           = "iam"
    environment          = "test"
    iam_default_password = "p4ssw2d"
  }
}
