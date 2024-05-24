terraform {
  required_version = "~>1.8.0"
  required_providers {
    aws = {
        
        source = "hashicorp/aws"
        version = "~>5.40.0"
    }
  }
  # BACKEND CONFIG FOR REMOTE STATE CURRENTLY USING LOCAL STATE
#   backend "s3" {
      
#   }
}