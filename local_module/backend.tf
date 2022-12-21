terraform {
  backend "s3" {
    bucket = "zoune-remotestate"
    key    = "aws/vm-local-module/terraform.tfstate"
    region = "us-east-1"
  }
}