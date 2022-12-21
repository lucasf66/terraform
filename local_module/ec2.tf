resource "aws_key_pair" "key" {
  key_name   = "ssh-key-terraform"
  public_key = file("~/.ssh/terraform-aws-not-pag.pub")
}


resource "aws_instance" "vm" {
  ami                         = "ami-0b5eea76982371e91"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = module.network.subnet_id
  vpc_security_group_ids      = [module.network.sg_id]
  associate_public_ip_address = true
  tags = {
    Name = "Hello World - Terraform"
  }
}

