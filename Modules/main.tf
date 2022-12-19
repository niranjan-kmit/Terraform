Now, update this module block that will allow it to create an IAM User called max. Adhere to the following requirements:

Only use the module block in the main.tf file, do not add a separate resource block.
Module Name - iam_iam-user
Only add the single required argument at this time.

The provider.tf and variables.tf files have been added to this configuration directory now.
When ready, run a terraform init and plan. You don't have to provision the resources at this moment but you can try should you wish to!

Solution:
===========
module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "3.4.0"
  # insert the 1 required variable here
  name = "max"
}



We only want to create the IAM User. Update the module block to only allow create_user. Disable create_iam_access_key and create_iam_user_login_profile

Solution:
===========
module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "3.4.0"
  # insert the 1 required variable here
  name                          = "max"
  create_iam_user_login_profile = false
  create_iam_access_key         = false
}