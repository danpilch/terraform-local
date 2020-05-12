module "aws-enforce-mfa" {
  source = "jeromegamez/enforce-mfa/aws"
  groups = [
    aws_iam_group.read_only_users_group.name,
    aws_iam_group.aws_engineer_users_group.name
  ]
  users = []
}
