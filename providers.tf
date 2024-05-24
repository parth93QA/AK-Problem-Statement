provider "aws" {
  region = "us-east-1"
  alias = "us-east-1"
}

provider "aws" {
  region = "us-east-2"
  alias = "us-east-2"
}


terraform {
   backend "s3" {

    bucket = "tf-eks-state-store"
    key = "ec2/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "ec2-vpc-table"
  }
}