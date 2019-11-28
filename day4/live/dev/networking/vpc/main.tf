provider "aws" {
  region = "us-west-2"
}

module "my-vpc" {
  source = "../../../../modules/networking/vpc"

  vpc_cidr = "10.0.0.0/16"

  vpc_tags = {
      env = "dev"
      owner = "nishant"
  }
  
}

