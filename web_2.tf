resource "aws_subnet" "nat-b-subnet" {
  vpc_id            = aws_vpc.global_vpc.id
  cidr_block        = "172.16.1.128/26"
  availability_zone = "eu-west-1b"
}

resource "aws_network_interface" "eu-b-NIC" {
  subnet_id         = aws_subnet.nat-b-subnet.id
  private_ips       = ["172.16.1.150"]
  security_groups   = [ aws_security_group.security_group.id ]
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_route_table_association" "web-eu-b" {
  subnet_id               = aws_subnet.nat-b-subnet.id
  route_table_id          = aws_route_table.rt_public.id
  depends_on = [
    aws_instance.web-eu-b
  ]
}

resource "aws_instance" "web-eu-b" {
  ami               = var.instance_ami
  instance_type     = var.instance_type
  availability_zone = "eu-west-1b"
  key_name          = var.web2_public_key_name
  depends_on        = [ aws_instance.web-eu-a ]

  network_interface {
    network_interface_id = aws_network_interface.eu-b-NIC.id
    device_index         = 0
  }

  provisioner "file" {
    source      = "scripts/web_setup.sh"
    destination = "/tmp/web_setup.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/web_setup.sh",
      "sudo /tmp/web_setup.sh B",
      # "exit 0",
    ]
  }
  connection {
    type        = "ssh"
    agent       = false
    host        = self.private_ip
    user        = "ubuntu"
    private_key = file(var.private_key_path)

    bastion_host        = aws_instance.bastion.public_ip
    bastion_private_key = file(var.private_key_path)
  }
}