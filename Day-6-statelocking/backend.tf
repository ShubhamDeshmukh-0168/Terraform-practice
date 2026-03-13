terraform {
  backend "s3" {
    bucket = "deshmukh-23-test"
    key = "sd-terraform/terraform.tfstate"
    region = "us-east-1"
    }
    }