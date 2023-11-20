# main.tf
module "s3_bronze" {
  source      = "./modules/s3_bucket"
  bucket_name = var.bucket_name_bronze
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
