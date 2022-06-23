provider "aws" {
    version = "~> 4.15.1"
    region = "us-east-1"
}
resource "aws_instance" "dev"{
    count = 3
    ami = "ami-09d56f8956ab235b3"
    instance_type = "t2.micro"
    key_name = "terraform-aws-teste"
    tags = {
      "Name" = "dev${count.index}"
    }
    vpc_security_group_ids = ["sg-04d4c14d84fba1528"]
}

resource "aws_security_group" "acesso-ssh" {
  name = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["143.255.75.204/32"]
  }  
  tags = {
    "Name" = "ssh"
  }
}