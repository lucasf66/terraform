resource "aws_vpc" "vpc_remote_state" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-remote-state"
  }
}

resource "aws_subnet" "subnet_remote_state" {
  vpc_id     = aws_vpc.vpc_remote_state.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "subnet-remote-state"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_remote_state.id
  tags = {
    Name = "gw-remote-state"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc_remote_state.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route-table-terraform"
  }
}

resource "aws_route_table_association" "rt_associate" {
  subnet_id      = aws_subnet.subnet_remote_state.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "sg_remote_state" {
  name        = "Sg_remote_state"
  description = "Allow inbound/outbound"
  vpc_id      = aws_vpc.vpc_remote_state.id

  ingress {
    description = "Allow ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}