provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "tf_backend" {
  bucket = "terraform-state-orumpark"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_backend.id

  versioning_configuration {
    status = "Enabled"
  }
}


