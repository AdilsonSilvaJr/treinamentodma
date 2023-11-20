// variables.tf
variable "bucket_name_bronze" {
  description = "Name for the S3 bucket"
}

variable "bucket_name_silver" {
  description = "Name for the S3 bucket"
}

variable "bucket_name_gold" {
  description = "Name for the S3 bucket"
}

variable "bucket_name_resource" {
  description = "Name for the S3 bucket"
}

variable "crawler_name" {
  description = "Name for the Glue Crawler"
}

variable "database_name" {
  description = "Database name the Glue Crawler"
}