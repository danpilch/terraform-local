data "aws_iam_policy_document" "ec2_baseline_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_baseline" {
  name               = "ec2_baseline"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ec2_baseline_policy.json
}
