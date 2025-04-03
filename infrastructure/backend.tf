terraform {
  backend "s3" {
    bucket = "terraform-state-orumpark"
    key    = "infra/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

