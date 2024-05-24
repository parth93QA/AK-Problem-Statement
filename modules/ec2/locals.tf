locals {
  EC2_type = var.instance_type
  EC2_name = var.instance_name

  common_tags = {
    ec2_type = local.EC2_type
    ec2_name = local.EC2_name
  }
}