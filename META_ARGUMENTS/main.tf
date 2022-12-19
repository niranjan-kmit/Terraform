add a count argument to create 3 instances of this resource.

resource "local_file" "name" {
    filename = "/root/user-data"
    sensitive_content = "password: S3cr3tP@ssw0rd"
    count = 3
}



resource "local_file" "name" {
    filename = var.users[count.index]
    sensitive_content = var.content
    count = length(var.users)

}

Let's do the same exercise as before but this time we will make use of the for_each meta argument to create the files in this configuration.
resource "local_file" "name" {
    filename = each.value
    for_each = toset(var.users)
    sensitive_content = var.content

}