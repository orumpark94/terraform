provider "aws" {
  region = "ap-northeast-2"
}

# S3 버킷 (Backend용)
resource "aws_s3_bucket" "tf_backend" {
  bucket         = "terraform-state-orumpark"
  force_destroy  = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.tf_backend.id

  versioning_configuration {
    status = "Enabled"
  }
}

# 🔐 SSH 키 생성
resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 🔐 S3에 SSH 키 업로드
resource "aws_s3_object" "upload_ssh_key" {
  bucket  = aws_s3_bucket.tf_backend.bucket
  key     = "keys/generated-key.pem"
  content = tls_private_key.generated.private_key_pem

  tags = {
    Name = "terraform-uploaded-ssh-key"
  }
}
