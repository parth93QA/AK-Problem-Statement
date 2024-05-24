module "us-east-1-vpc"{
    source = "./modules/vpc"
    providers = {
      aws = aws.us-east-1
    }
    vpc_name = "vpc-us-east-1"
    vpc_region = "us-east-1"
    
}

module "us-east-1-ec2" {
  source = "./modules/ec2"
  providers = {
    aws = aws.us-east-1
  }
  vpc_id = module.us-east-1-vpc.vpc_id
  public_subnet_id = module.us-east-1-vpc.public_subnets[0]
  instance_name = "${var.instance_name}-us-east-1"
}



module "us-east-2-vpc" {
  source = "./modules/vpc"
  providers = {
    aws = aws.us-east-2
  }
  vpc_name = "vpc-us-east-2"
  vpc_region = "us-east-2"
}


module "us-east-2-ec2" {
  source = "./modules/ec2"
  providers = {
    aws = aws.us-east-2
  }
  vpc_id = module.us-east-2-vpc.vpc_id
  public_subnet_id = module.us-east-2-vpc.public_subnets[1]
  instance_name = "${var.instance_name}-us-east-1"
}
