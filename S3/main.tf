The main.tf file is empty. Use it to create a new S3 with the following specifications:
resource name: dc_bucket
bucket name: dc_is_better_than_marvel

Solution:
==========
resource "aws_s3_bucket" "dc_bucket" {
  bucket = "dc_is_better_than_marvel"
  }


  Let's fix that now and change the bucket name so that it uses dashes (-) instead of underscore(_).
  resource name: dc_bucket
  bucket name: dc-is-better-than-marvel

  Solution :
  ==========
  resource "aws_s3_bucket" "dc_bucket" {
       bucket = "dc-is-better-than-marvel"
  }


  Let's do that now and upload this image to the s3 bucket! Update the main.tf file with the following specifications:
  Bucket: pixar-studios-2020
  Key: woody.jpg
  Source: /root/woody.jpg

  Solution :
  ============
  resource "aws_s3_bucket_object" "upload" {
    bucket = "pixar-studios-2020"
    key    = "woody.jpg"
    source = "/root/woody.jpg"
  }