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


data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "zoune-remotestate"
    key    = "aws/terraform.tfstate"
    region = "us-east-1"
  }
}