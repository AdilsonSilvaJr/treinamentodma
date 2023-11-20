resource "aws_glue_crawler" "example" {
  name          = var.crawler_name
  role          = var.role_arn
  database_name = var.database_name

  s3_target {
    path = var.crawler_s3path
  }

  // other glue crawler configuration...
}
