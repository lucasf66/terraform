terraform {
  backend "s3" {
    bucket = "zoune-remotestate"
    key    = "aws/terraform.tfstate"
    region = "us-east-1"
  }
}