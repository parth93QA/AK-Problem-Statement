module "us-east-1-vpc"{
    source = "./modules/vpc"
    providers = {
      aws = aws.us-east-1
    }
    vpc_name = "vpc-us-east-1"
    vpc_region = "us-east-1"
    azs = ["us-east-1a","us-east-1b"]
    
}

module "us-east-1-ec2" {
  source = "./modules/ec2"
  providers = {
    aws = aws.us-east-1
  }
  vpc_id = module.us-east-1-vpc.vpc_id
  public_subnet_id = element(module.us-east-1-vpc.public_subnets[*].id, 0)
  instance_name = "${var.instance_name}-us-east-1"
}



module "us-east-2-vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.us-east-2
  }
  vpc_name = "vpc-us-east-2"
  vpc_region = "us-east-2"
  azs = ["us-east-2a","us-east-2b"]
}


module "us-east-2-ec2" {
  source = "./modules/ec2"
  providers = {
    aws = aws.us-east-2
  }
  vpc_id = module.us-east-2-vpc.vpc_id
  public_subnet_id = element(module.us-east-2-vpc.public_subnets[*].id, 0)
  instance_name = "${var.instance_name}-us-east-2"
}
