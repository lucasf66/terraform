terraform {
  backend "s3" {
    bucket = "zoune-remotestate"
    key    = "aws/vm/terraform.tfstate"
    region = "us-east-1"
  }
}