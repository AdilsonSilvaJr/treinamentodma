data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/zip/Lambda_CsvtoParquet.zip"
}

resource "aws_lambda_function" "lambda_func" {
  filename         = "${path.module}/zip/Lambda_CsvtoParquet.zip"
  function_name    = "Lambda_CsvtoParquet"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.lambda_handler"
  source_code_hash = data.archive_file.zip_the_python_code.output_base64sha256
  runtime          = "python3.8"
  timeout          = "180"
  depends_on       = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
  layers           = ["arn:aws:lambda:us-east-1:336392948345:layer:AWSSDKPandas-Python38:11"]
}
