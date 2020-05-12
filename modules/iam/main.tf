resource "aws_ssm_parameter" "secret" {
  name        = "/${var.iam_config.environment}/iam/password/default"
  description = "Initial default iam user password"
  type        = "SecureString"
  value       = var.iam_config.iam_default_password

  tags = {
    Environment = var.iam_config.environment
    Terraform   = true
  }
}
