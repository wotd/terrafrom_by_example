variable "aws_access_key" {
  description = "AWS Access Key"
  default = ""
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  default = ""
}

variable "region" {
  description = "AWS Region"
  default = "eu-west-1"
}

variable "bastion_public_key" {
  description = "ssh public key"
  default = "<< PUT PUBLIC KEY HERE>>"
}

variable "bastion_public_key_name" {
  description = "bastion ssh public key"
  default = "bastion_key"
}

variable "web1_public_key" {
  description = "web1 ssh public key"
  default = "<< PUT PUBLIC KEY HERE>>"
}

variable "web1_public_key_name" {
  description = "web1 ssh public key"
  default = "web1_key"
}

variable "web2_public_key" {
  description = "web2 ssh public key"
  default = "<< PUT PUBLIC KEY HERE>>"
}

variable "web2_public_key_name" {
  description = "web2 ssh public key"
  default = "web2_key"
}

variable "private_key_path" {
  default = "keys/aws_rsa"
}

variable "instance_ami" {
  description = "AMI for aws EC2 instances"
  default = "ami-08bac620dc84221eb"
}

variable "instance_type" {
  description = "type for aws EC2 instance"
  default = "t2.micro"
}

variable "nat_ami" {
  description = "AMI for NAT instance"
  default = "ami-01ae0e01e7fffd105"
}