variable "vpc_name" {
  description = "VPC Name"
  type = string 
  default = "myvpc"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

variable "vpc_public_subnets" {
  type = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_private_subnets" {
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_enable_nat_gateway" {
  type = bool
  default = true  
}

variable "vpc_single_nat_gateway" {
  type = bool
  default = true
}

variable "vpc_region" {
  type = string
  default = "us-east-1"
}

variable "azs" {
  type = list(string)
}