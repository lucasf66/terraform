resource "aws_key_pair" "key" {
  key_name   = "ssh-key-terraform"
  public_key = file("~/.ssh/terraform-aws-not-pag.pub")
}


resource "aws_instance" "vm" {
  ami                         = "ami-0b5eea76982371e91"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.key.key_name
  subnet_id                   = data.terraform_remote_state.vpc.outputs.subnet_id
  vpc_security_group_ids      = [data.terraform_remote_state.vpc.outputs.sg_id]
  associate_public_ip_address = true
  tags = {
    Name = "Hello World - Terraform"
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> ip_vm.txt"
  }

  provisioner "file" {
    content     = "public_ip : ${self.public_ip}"
    destination = "/tmp/public_ip.txt"
  }

  provisioner "file" {
    source      = "./ip_vm.txt"
    destination = "/tmp/public_ip.txt"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/terraform-aws-not-pag")
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${self.ami} >> /tmp/ami.txt"
    ]
  }

}

