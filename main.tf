provider "aws" {
  region = "ap-northeast-2"  
}

resource "aws_instance" "minimal" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "terraform-minimal-instance"
  }
}
