resource "aws_key_pair" "bastion_key" {
  key_name   = var.bastion_public_key_name
  public_key = var.bastion_public_key
}

resource "aws_key_pair" "web1_key" {
  key_name   = var.web1_public_key_name
  public_key = var.web1_public_key
}

resource "aws_key_pair" "web2_key" {
  key_name   = var.web2_public_key_name
  public_key = var.web2_public_key
}