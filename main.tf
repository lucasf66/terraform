provider "aws" {
    version = "4.15.1"
    region = "us-east-1"
}

resource "aws_instance" "dev" {
    count = 3
    ami = "ami-09d56f8956ab235b3"
    instance_type = "t2.micro"
    key_name = "terraform-key"
    tags = {
      "Name" = "dev${count.index}"
    }
}
