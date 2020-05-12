resource "aws_iam_user" "dan_pilch" {
  name = "dan_pilch"
  path = "/system/"

  tags = {
    Name        = "dan_pilch"
    Environment = var.iam_config.environment
  }
}

resource "aws_iam_user" "read_only_test_user" {
  name = "read_only_test_user"
  path = "/system/"

  tags = {
    Name        = "read_only_test_user"
    Environment = var.iam_config.environment
  }
}

