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

variable "key_name" {
  description = "EC2 인스턴스에 접속할 때 사용할 키 페어 이름"
  type        = string
}

# 네트워크 설정
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# 기존 subnet_cidr는 제거하고 아래 두 개로 분리
variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "availability_zone" {
  default = "ap-northeast-2a"
}

# RDS 설정
variable "db_password" {
  description = "RDS 인스턴스의 관리자 비밀번호"
  type        = string
  sensitive   = true
}
