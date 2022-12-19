Let's manage this instance called jade-mw with Terraform! First, create an empty resource block for this instance in the main.tf file in the configuration directory /root/terraform-projects/project-jade
Use jade-mw as the resource name.

Solution:
=========
resource "aws_instance" "ruby" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = var.name
  key_name      = var.key_name
  tags = {
    Name = each.value
  }
}
output "instances" {
 value = aws_instance.ruby
}
resource "aws_instance" "jade-mw" {

}

Now, import this instance into the terraform state.

The resource name should be the same as the one used in the previous question - jade-mw

Run the terraform import command: terraform import aws_instance.jade-mw id-of-the-resource.
Where, id-of-the-resource is the id of the instance that we determined in the previous question.