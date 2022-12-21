terraform {
  backend "s3" {
    bucket = "zoune-remotestate"
    key    = "aws/vm-provisioner/terraform.tfstate"
    region = "us-east-1"
  }
}