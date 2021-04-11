resource "aws_subnet" "pub-subnet-a" {
  vpc_id                  = aws_vpc.global_vpc.id
  cidr_block              = "172.16.1.0/26"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true
}

resource "aws_route_table_association" "bastion" {
  subnet_id               = aws_subnet.pub-subnet-a.id
  route_table_id          = aws_route_table.rt_public.id
}

resource "aws_network_interface" "pub-bastion-a-NIC" {
  subnet_id               = aws_subnet.pub-subnet-a.id
  private_ips             = ["172.16.1.10"]
  security_groups         = [ aws_security_group.bastion_security_group.id ]
}

resource "aws_instance" "bastion" {
  ami                     = var.instance_ami
  instance_type           = var.instance_type
  availability_zone       = "eu-west-1a"
  key_name                = var.bastion_public_key_name
  depends_on              = [ aws_route_table_association.bastion ]

    network_interface {
    network_interface_id  = aws_network_interface.pub-bastion-a-NIC.id
    device_index          = 0
  }
}