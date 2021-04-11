output "public_instance_id" {
  value = aws_instance.bastion.id
}

output "public_instance_ip" {
  value = aws_instance.bastion.public_ip
}

output "public_dns" {
  value = aws_lb.web_alb.dns_name
}