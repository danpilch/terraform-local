data "cloudflare_ip_ranges" "cloudflare" {}
# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_config.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name      = join("-", [var.vpc_config.stack_name, "vpc"])
    Terraform = true
  }
}

# Public NACL
resource "aws_network_acl" "general_public_nacl" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = join("-", [var.vpc_config.stack_name, "public"])
    Terraform = true
  }
}

# Private NACL  
resource "aws_network_acl" "general_private_nacl" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name      = join("-", [var.vpc_config.stack_name, "public"])
    Terraform = true
  }
}

# Public NACL Rules
resource "aws_network_acl_rule" "general_public_nacl_ingress_rule_100" {
  network_acl_id = aws_network_acl.general_public_nacl.id
  rule_number    = 100
  protocol       = "-1"
  egress         = false
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "general_public_nacl_egress_rule_100" {
  network_acl_id = aws_network_acl.general_public_nacl.id
  rule_number    = 100
  protocol       = "-1"
  egress         = true
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

# Private NACL Rules
resource "aws_network_acl_rule" "general_private_nacl_ingress_rule_100" {
  network_acl_id = aws_network_acl.general_private_nacl.id
  rule_number    = 100
  protocol       = "-1"
  egress         = false
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "general_private_nacl_ingress_rule_120" {
  network_acl_id = aws_network_acl.general_private_nacl.id
  rule_number    = 120
  protocol       = "1"
  egress         = false
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  icmp_type      = "-1"
  icmp_code      = "-1"
}

resource "aws_network_acl_rule" "general_private_nacl_ingress_rule_140" {
  network_acl_id = aws_network_acl.general_private_nacl.id
  rule_number    = 140
  protocol       = "17"
  egress         = false
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "general_private_nacl_egress_rule_100" {
  network_acl_id = aws_network_acl.general_private_nacl.id
  rule_number    = 100
  protocol       = "-1"
  egress         = true
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
}

# General Private subnets
resource "aws_subnet" "general_private_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false
  cidr_block              = var.vpc_config.general_private_subnet_a_cidr
  availability_zone       = var.vpc_config.availability_zone_a

  tags = {
    Name      = join("-", [var.vpc_config.stack_name, "general-private-a"])
    Terraform = true
  }
}

resource "aws_subnet" "general_private_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false
  cidr_block              = var.vpc_config.general_private_subnet_b_cidr
  availability_zone       = var.vpc_config.availability_zone_b

  tags = {
    Name      = join("-", [var.vpc_config.stack_name, "general-private-b"])
    Terraform = true
  }
}

# Shared Services Public Subnets
resource "aws_subnet" "shared_services_public_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false
  cidr_block              = var.vpc_config.shared_services_public_subnet_a_cidr
  availability_zone       = var.vpc_config.availability_zone_a

  tags = {
    Name      = join("-", [var.vpc_config.stack_name, "shared-public-a"])
    Terraform = true
  }
}

resource "aws_subnet" "shared_services_public_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false
  cidr_block              = var.vpc_config.shared_services_public_subnet_b_cidr
  availability_zone       = var.vpc_config.availability_zone_b

  tags = {
    Name      = join("-", [var.vpc_config.stack_name, "shared-public-b"])
    Terraform = true
  }
}

# Shared Services Private Subnets
resource "aws_subnet" "shared_services_private_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false
  cidr_block              = var.vpc_config.shared_services_private_subnet_a_cidr
  availability_zone       = var.vpc_config.availability_zone_a

  tags = {
    Name      = join("-", [var.vpc_config.stack_name, "shared-private-a"])
    Terraform = true
  }
}

resource "aws_subnet" "shared_services_private_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = false
  cidr_block              = var.vpc_config.shared_services_private_subnet_b_cidr
  availability_zone       = var.vpc_config.availability_zone_b

  tags = {
    Name      = join("-", [var.vpc_config.stack_name, "shared-private-b"])
    Terraform = true
  }
}

# Shared Services Public NACL Associations
#todo https://github.com/terraform-providers/terraform-provider-aws/issues/5466
