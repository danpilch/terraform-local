resource "aws_iam_group_membership" "read_only_group_membership" {
  name = "read_only_group_membership"

  users = [
    aws_iam_user.read_only_test_user.name,
  ]

  group = aws_iam_group.read_only_users_group.name
}
