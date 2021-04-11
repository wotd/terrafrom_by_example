resource "aws_instance" "nat" {
  ami                     = var.nat_ami
  instance_type           = var.instance_type
  availability_zone       = "eu-west-1a"
  key_name                = var.bastion_public_key_name
  source_dest_check       = false
  subnet_id               = aws_subnet.pub-subnet-a.id
  security_groups         = [ aws_security_group.nat_security_group.id ]
}