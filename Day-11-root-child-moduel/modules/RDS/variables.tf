variable "subnet_1_id" { type = string }
variable "subnet_2_id" { type = string }
variable "instance_class" { type = string }
variable "db_name" { type = string }
variable "db_user" { type = string }
variable "db_password" { type = string }
variable "vpc_security_group_ids" { type = list(string) }