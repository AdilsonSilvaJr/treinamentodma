# main.tf
module "s3_bronze" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name_bronze
}

module "s3_bronze_notification" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/notification"
  version = "3.15.1"
  bucket = module.s3_bronze.s3_bucket_id
  bucket_arn = module.s3_bronze.s3_bucket_arn
  eventbridge = true
}

module "s3_silver" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name_silver
}

module "s3_gold" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name_gold
}

module "s3_resources" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name_resource
}
