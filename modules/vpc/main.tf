# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = join("-", [var.stack_name, "vpc"])
    Terraform = "true"
  }
}

# Public NACL
resource "aws_network_acl" "general_public_nacl" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = join("-", [var.stack_name, "public"])
    Terraform = true
  }
}

# Private NACL  
resource "aws_network_acl" "general_private_nacl" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = join("-", [var.stack_name, "public"])
    Terraform = true
  }
}

# Public NACL Rules
resource "aws_network_acl_rule" "general_public_nacl_ingress_rule_100" {
  network_acl_id = aws_network_acl.general_public_nacl.id
  rule_number = 100
  protocol = "-1"
  egress = false
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "general_public_nacl_egress_rule_100" {
  network_acl_id = aws_network_acl.general_public_nacl.id
  rule_number = 100
  protocol = "-1"
  egress = true
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
}

# Private NACL Rules
resource "aws_network_acl_rule" "general_private_nacl_ingress_rule_100" {
  network_acl_id = aws_network_acl.general_public_nacl.id
  rule_number = 100
  protocol = "-1"
  egress = false
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "general_private_nacl_egress_rule_100" {
  network_acl_id = aws_network_acl.general_public_nacl.id
  rule_number = 100
  protocol = "-1"
  egress = true
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
}
