resource "aws_instance" "cerberus" {
  ami           = "ami-06178cf087598769c"
  instance_type = "m5.large"
  key_name = aws_key_pair.cerberus-key.id



  user_data = <<-EOF
              #!/bin/bash
               sudo yum update -y
               sudo yum install nginx -y
               sudo systemctl start nginx
               EOF
}


resource "aws_key_pair" "cerberus-key" {
  key_name   = "cerberus"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDh/9xpyZaLuZl6AbL5p7wS++rr3H+wBiGyUTlobTLfWK2D2yx1hPOVQfREW6YJQoCNcyGIXqRpFlkqiGvsnADQYW73fMxr+qyyQjp3r4rgKjLYvhPtsfUC+qjA7f95Ukjs3AbaUxClTXWUMoqenIDrga1ukw0duYwOIbjAIwHQyHDcRf1RN1KQ0MhGn1+0U5BzFaNMlCwLTDsFTdcG46+FFjK/t6aaRA4BGD7DrOYhEBbZF9BPkN4bHqu7eVvdWLWXrOtpzNbrjvOQenrlSKqXUUZKOIblzcqxh6NCzqPbZrWieXXslAhSxki1lqQ4PB3xslbGQRj63obYIhZ3cgSn root@iac-server"
}

resource "aws_eip" "eip" {
  instance = aws_instance.cerberus.id
  vpc      = true

   provisioner "local-exec" {
    command = "echo ${self.public_dns} >> /root/cerberus_public_dns.txt"
  }
}
