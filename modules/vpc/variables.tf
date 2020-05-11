variable "cidr_block" {
  description = "CIDR block to use for VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "stack_name" {
  description = "Stack name"
  type        = string
}
