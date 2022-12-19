Navigate to the directory /root/terraform-projects/project-cerberus. We have an empty main.tf file in this directory.
Using this configuration file write a resource block to provision a simple EC2 instance with the following specifications:

Resource Name: cerberus
AMI: ami-06178cf087598769c, use variable named ami
region: eu-west-2, use variable named region
Instance Type: m5.large, use variable named instance_type

Solution :
=============
variable "ami" {
  default = "ami-06178cf087598769c"
}

variable "instance_type" {
  default = "m5.large"
}

variable "region" {
  default = "eu-west-2"
}

resource "aws_instance" "cerberus" {
  ami           = var.ami
  instance_type = var.instance_type
}



TASK:
=====
A new SSH key pair has been created in the directory /root/terraform-projects/project-cerberus/.ssh.
The private key is called cerberus and the public key is called cerberus.pub

Using the public key, create a new key-pair in AWS with the following specifications:
Resource Name: cerberus-key
key_name: cerberus
Use the file functions to read the the public key cerberus.pub


Solution:
=========
variable "ami" {
  default = "ami-06178cf087598769c"
}
variable "instance_type" {
    default = "m5.large"

}
variable "region" {
  default = "eu-west-2"
}
resource "aws_instance" "cerberus" {
    ami = var.ami
    instance_type = var.instance_type

}
#You can also use variable for key_name
resource "aws_key_pair" "cerberus-key" {
    key_name = "cerberus"
    public_key = file(".ssh/cerberus.pub")
}

Let us now configure the cerberus resource to make use of this key. Update the resource block to make use of the key called cerberus.

Solution :
===========
resource "aws_instance" "cerberus" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = "cerberus"
}




Let us now install nginx in this EC2 instance. To do this, let's make use of the user_data argument.
Using the file function again or by making use of the heredoc syntax, use the script called install-nginx.sh as the value for the user_data argument.

Solution :
========
variable "ami" {
  default = "ami-06178cf087598769c"
}
variable "instance_type" {
    default = "m5.large"

}
variable "region" {
  default = "eu-west-2"
}
resource "aws_instance" "cerberus" {
    ami = var.ami
    instance_type = var.instance_type
    key_name  = "cerberus"
    user_data = file("./install-nginx.sh")

}
resource "aws_key_pair" "cerberus-key" {
    key_name = "cerberus"
    public_key = file(".ssh/cerberus.pub")
}



We use the public IPv4 address to access this server. However, when this server is rebooted or recreated, this IP address would change.
To fix this, let's create an Elastic IP Address.
An Elastic IP address is a static IPv4 address which does not change over time.
Create an Elastic IP resource with the following specifications:
Resource Name: eip
vpc: true
instance: id of the EC2 instance created for resource cerberus (use a reference expression)
create a local-exec provisioner for the eip resource and use it to print the attribute called public_dns to a file /root/cerberus_public_dns.txt on the iac-server.


Solution:
============
resource "aws_instance" "cerberus" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = file("./install-nginx.sh")

}
resource "aws_key_pair" "cerberus-key" {
  key_name   = "cerberus"
  public_key = file(".ssh/cerberus.pub")
}
resource "aws_eip" "eip" {
  vpc      = true
  instance = aws_instance.cerberus.id
  provisioner "local-exec" {
    command = "echo ${aws_eip.eip.public_dns} >> /root/cerberus_public_dns.txt"
  }

}
variable "ami" {
  default = "ami-06178cf087598769c"
}
variable "instance_type" {
  default = "m5.large"

}
variable "region" {
  default = "eu-west-2"
}