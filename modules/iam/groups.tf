resource "aws_iam_group" "read_only_users_group" {
  name = "read_only_users_group"
}

resource "aws_iam_group" "aws_engineer_users_group" {
  name = "aws_engineer_users_group"
}
