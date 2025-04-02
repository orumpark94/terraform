variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "ap-northeast-2"  
}

variable "ami_id" {
  default = "ami-0e001c9271cf7f3b9"  
}

variable "instance_type" {
  default = "t2.micro"  
}
