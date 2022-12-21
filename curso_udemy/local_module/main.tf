terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.48.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
}


module "network" {
  source      = "./network"
  cidr_vpc    = "10.0.0.0/16"
  cidr_subnet = "10.0.0.0/24"
  environment = "Dev"
}