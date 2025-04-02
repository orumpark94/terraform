provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "minimal" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "terraform-minimal-instance"
  }
}
