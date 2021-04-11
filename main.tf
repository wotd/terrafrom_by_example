provider "aws" {
  profile = "default"
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
  region  = var.region
}

resource "aws_vpc" "global_vpc" {
  cidr_block = "172.16.1.0/24"
  enable_dns_hostnames  = true
  enable_dns_support    = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id                = aws_vpc.global_vpc.id
}

resource "aws_route_table" "rt_public" {
  vpc_id                = aws_vpc.global_vpc.id
  depends_on        = [ aws_internet_gateway.gw ]
  route {
    cidr_block          = "0.0.0.0/0"
    gateway_id          = aws_internet_gateway.gw.id
    }
}

resource "aws_route_table" "rt_nat" {
  vpc_id                = aws_vpc.global_vpc.id
  depends_on        = [ aws_instance.nat ]
  route {
    cidr_block          = "0.0.0.0/0"
    instance_id          = aws_instance.nat.id
    }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.global_vpc.id
  route_table_id = aws_route_table.rt_nat.id
}
