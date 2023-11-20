
module "glue_crawler" {
  source         = "./modules/glue_crawler"
  crawler_name   = var.crawler_name
  role_arn       = aws_iam_role.crawler_role.arn
  database_name  = var.database_name
  crawler_s3path = "s3://${module.s3_silver.s3_bucket_id}/transactions/"
  depends_on     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]

  # other glue crawler variables...
}