## dev environment variables##
#here dev = defualt profile in provider.tf
variable "ami_id" {
  default = ""
  type = string
  
}
variable "instance_type" {
  default = ""
  type = string
}


## test environment variables##
variable "test_ami_id" {
  default = ""
  type = string
  
}
variable "test_instance_type" {
  default = ""
  type = string
}

## prod environment variables##
variable "prod_ami_id" {
  default = ""
  type = string
  
}
variable "prod_instance_type" {
  default = ""
  type = string
} 