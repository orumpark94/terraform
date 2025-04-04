provider "aws" {
  region = "ap-northeast-2"
}

# 이미 존재하는 S3 버킷 사용
data "aws_s3_bucket" "existing_tf_backend" {
  bucket = "terraform-state-orumpark"
}

# 🔐 SSH 키 생성
resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 🔐 기존 S3 버킷에 SSH 키 업로드
resource "aws_s3_object" "upload_ssh_key" {
  bucket  = data.aws_s3_bucket.existing_tf_backend.id
  key     = "keys/generated-key.pem"
  content = tls_private_key.generated.private_key_pem

  tags = {
    Name = "terraform-uploaded-ssh-key"
  }
}
