variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for bucket"
  type        = map(string)
  default     = {}
}