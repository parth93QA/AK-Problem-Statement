locals {
  VPC_NAME = var.vpc_name
  VPC_REGION = var.vpc_region
  common_tags = {
    vpc = local.VPC_NAME
    vpc_region = local.VPC_REGION

  }
}