variable "vpc_config" {
  type = object({
    stack_name                            = string
    cidr_block                            = string
    availability_zone_a                   = string
    availability_zone_b                   = string
    general_private_subnet_a_cidr         = string
    general_private_subnet_b_cidr         = string
    shared_services_public_subnet_a_cidr  = string
    shared_services_public_subnet_b_cidr  = string
    shared_services_private_subnet_a_cidr = string
    shared_services_private_subnet_b_cidr = string
  })
  default = {
    stack_name                            = "vpc"
    cidr_block                            = "10.2.0.0/16"
    availability_zone_a                   = "eu-west-1a"
    availability_zone_b                   = "eu-west-1c"
    general_private_subnet_a_cidr         = "10.2.0.0/21"
    general_private_subnet_b_cidr         = "10.2.8.0/21"
    shared_services_public_subnet_a_cidr  = "10.2.16.0/21"
    shared_services_public_subnet_b_cidr  = "10.2.24.0/21"
    shared_services_private_subnet_a_cidr = "10.2.32.0/21"
    shared_services_private_subnet_b_cidr = "10.2.40.0/21"
  }
}
