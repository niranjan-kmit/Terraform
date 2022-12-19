Let's fix that now! Update the main.tf file so that it uses an attribute for the Primary/Hash Key.
Note that the UserId should be a number.

Solution:
========
resource "aws_dynamodb_table" "project_sapphire_user_data" {
  name           = "userdata"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "N"
  }
}



Now, let's add an item to this table called inventory. Use the following specifications and update the main.tf file:

Resource Name: upload
Table = Use reference expression to the table called inventory
Hash Key = Use reference expression to use the primary key used by the table inventory

Use the below data for item:
{
"AssetID": {"N": "1"},
"AssetName": {"S": "printer"},
"age": {"N": "5"},
"Hardware": {"B": "true" }
}


Solution :
===========
resource "aws_dynamodb_table" "project_sapphire_inventory" {
  name           = "inventory"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "AssetID"

  attribute {
    name = "AssetID"
    type = "N"
  }
  attribute {
    name = "AssetName"
    type = "S"
  }
  attribute {
    name = "age"
    type = "N"
  }
  attribute {
    name = "Hardware"
    type = "B"
  }
  global_secondary_index {
    name             = "AssetName"
    hash_key         = "AssetName"
    projection_type    = "ALL"

  }
  global_secondary_index {
    name             = "age"
    hash_key         = "age"
    projection_type    = "ALL"

  }
  global_secondary_index {
    name             = "Hardware"
    hash_key         = "Hardware"
    projection_type    = "ALL"

  }
}
resource "aws_dynamodb_table_item" "upload" {
  table_name = aws_dynamodb_table.project_sapphire_inventory.name
  hash_key   = aws_dynamodb_table.project_sapphire_inventory.hash_key
  item = <<EOF
 {
  "AssetID": {"N": "1"},
  "AssetName": {"S": "printer"},
  "age": {"N": "5"},
  "Hardware": {"B": "true" }
}
EOF
}
