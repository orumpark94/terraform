# 기본 설정들
variable "region" {
  default = "ap-northeast-2"
}

variable "ami_id" {
  default = "ami-0c1989c90aa86e7cf"  # Ubuntu 22.04 (x86_64)
}

variable "instance_type" {
  default = "t2.micro"
}

# 네트워크 설정 추가
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  default = "ap-northeast-2a"
}
