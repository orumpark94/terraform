# access_key와 secret_key는 GitHub Actions 환경변수로 대체되므로 변수 제거

variable "region" {
  default = "ap-northeast-2"  
}

variable "ami_id" {
  default = "ami-0e001c9271cf7f3b9"  
}

variable "instance_type" {
  default = "t2.micro"  
}
