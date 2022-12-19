A new configuration directory has been created at /root/terraform-projects/project-lexcorp. A data source block is defined in the main.tf file to read the contents of an existing file.
There is also an output variable that uses reference expression to print the file content using this data source. However, there is something wrong!

Troubleshoot and fix the issue.

When ready, run terraform init, plan and apply to create the datasource. The configuration should print the output variable correctly.


Solution:
===========
output "os-version" {
  value = data.local_file.os.content
}
data "local_file" "os" {
  filename = "/etc/os-release"
}

We have now created a new configuration file called ebs.tf within the same configuration directory we have been working on.

data "aws_ebs_volume" "gp2_volume" {
  most_recent = true

  filter {
    name   = "volume-type"
    values = ["gp2"]
  }
}


Another file called s3.tf has now been created. It too has a data source that will be used to read data of an existing s3 bucket.

data "aws_s3_bucket" "selected" {
  bucket = "bucket.test.com"
}