terraform {
  backend "s3" {
    bucket = "shubham-09"
    key    = "project/terraform.tf"
    region = "us-east-1-k"
  }
}
