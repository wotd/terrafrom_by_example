resource "aws_security_group" "security_group" {
  name        = "allow_http"
  description = "Allow HTTP & SSH inbound traffic"
  vpc_id      = aws_vpc.global_vpc.id

  ingress {
    description = "Allow HTTP from LB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ aws_vpc.global_vpc.cidr_block ]
  }

  ingress {
    description = "Allow SSH from Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "172.16.1.10/32", "172.16.1.210/32" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group" "bastion_security_group" {
  name        = "allow_ssh"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.global_vpc.id

  ingress {
    description = "Allow SSH to Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0", "3.8.37.24/29" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group" "lb_security_group" {
  name        = "allow_http_to_lb"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.global_vpc.id

  ingress {
    description = "Allow HHTP from ANYWHERE"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_security_group" "nat_security_group" {
  name        = "nat_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.global_vpc.id

  ingress {
    description = "Allow all trafic from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ aws_vpc.global_vpc.cidr_block ] # [ "172.16.1.0/24" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}