variable "project_name" {
  type = string
  default = "storm"
}
variable "department" {
  type = string
  default = "finance"
}
locals {
   instance_name = "${var.project_name}-${var.department}-server"
}

variable "ami" {
    default  = "ami-06178cf087598769c"

}
variable "instance_type" {
    default = "m5.large"

}
variable "region" {
    default = "eu-west-2"

}
resource "aws_instance" "storm" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
      Name = local.instance_name
    }

}