data "aws_caller_identity" "current" {}

data "template_file" "sfn_transaction" {
  template = file("${path.module}/stepfunctionjson/transaction.json")
}