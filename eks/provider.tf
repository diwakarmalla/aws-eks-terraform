terraform {
  backend "s3" {
    
  }
}
provider "aws" {
  region = "us-east-1"
}

data "aws_availability_zones" "available" {
  state = "available"
}


data "aws_caller_identity" "current" {}