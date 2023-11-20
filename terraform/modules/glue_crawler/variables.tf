// variables.tf
variable "crawler_name" {
  description = "Name for the Glue Crawler"
  default = ""
}

variable "role_arn" {
  description = "IAM Role ARN for the Glue Crawler"
  default = ""
}

variable "database_name" {
  description = "List of targets for the Glue Crawler"
}

variable "crawler_s3path" {
  description = "S3 target path for the Glue Crawler"
}
