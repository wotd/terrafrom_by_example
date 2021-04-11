# Terraform files to deploy sample infrastructure

## Infrastructure description

**Two Webservers** are located in private subnets in two different AZs. To access them with SSH you should use **Bastion instance** (which is also deployed). 
Network (internet) access during webservers deployment process is provided by **NAT Instance** located in public network. 
Websites can be browsed thanks **ALB**.

Everything can be easily spinned with Terraform and is **free tier eligible**.

To provision webservers, simple bash script is used (**web_setup.sh**)

## Terraform output

```public_dns = "<< PUBLIC DNS OF ALB >>" (you can access websites here)
public_instance_id = "<< BASTION INSTANCE ID >>"
public_instance_ip = "<< IP ADDRESS >>" (you can ssh to this host using your ssh-keys)```
