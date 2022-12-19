Let's start off by creating an IAM User called mary but this time by making use of Terraform. In the configuration directory /root/terraform-projects/IAM, create a file called iam-user.tf with the following specifications:

Resource Type: aws_iam_user
Resource Name: users
Name: mary


Solution:
===========
resource "aws_iam_user" "users" {
     name = "mary"
}

Note : As we learned in the lecture, the AWS provider requires a region to be defined. Either in the provider block or by setting a value for the variable called region. This has not been done so far.



Add a new file called provider.tf containing a provider block for aws.
Inside this block add a single argument called region with the value ca-central-1

Solution :
============
provider "aws" {
     region = "ca-central-1"

}


Now, update the iam-user.tf to make use of the count meta-argument to loop through the project-sapphire-users variable and create all the users in the list.

You may want to make use of the length function to get the length of the list.

Solution :
============
resource "aws_iam_user" "users" {
     name = var.project-sapphire-users[count.index]
     count = length(var.project-sapphire-users)
}