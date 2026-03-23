variable "instance_class" {
  description = "RDS instance type"
  type        = string
}

variable "db_name" {
  
}

variable "db_user" {
  
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "ami_id" {
  
}
variable "instance_type" {
  
}
