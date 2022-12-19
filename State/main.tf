First, create a simple configuration to create a local_file resource within the directory called RemoteState. The resource block should be created inside the main.tf file. Follow the below specifications for provisioning this resource:
Resource Name: state
filename: /root/<variable local-state>
content: "This configuration uses <variable local-state> state"

Use the variable called local-state in the variables.tf file which is already created for you and make use of variable interpolation syntax ${..}.


Solution:
============
resource "local_file" "state" {
  filename = "/root/${var.local-state}"
  content  = "This configuration uses ${var.local-state} state"

}


Before we add the configuration for the s3 backend, let's first change the local file resource. Change the variable used to remote-state instead of local-state.

Once done, run terraform plan and apply

Solution :
==========
resource "local_file" "state" {
  filename = "/root/${var.remote-state}"
  content  = "This configuration uses ${var.remote-state} state"

}



Great! Now, let us configure the remote backend with s3. Add a terraform block in a new file called terraform.tf with the following arguments:

bucket: remote-state
key: terraform.tfstate
region: us-east-1

Do not run terraform init yet! Since we are making use of minio we also have to add a couple of additional arguments to get this to work!

Solution :
============
terraform {
  backend "s3" {
    key = "terraform.tfstate"
    region = "us-east-1"
    bucket = "remote-state"

  }
}