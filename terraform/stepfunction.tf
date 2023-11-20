locals {
  stepfunction_name = "treinamentodma"
}

# CloudWatch log group stepfunction
resource "aws_cloudwatch_log_group" "this" {
    name = "/aws/vendedlogs/states/${local.stepfunction_name}"
    retention_in_days = 1
}

# Stepfunction
resource "aws_sfn_state_machine" "this" {
    name = local.stepfunction_name
    role_arn = aws_iam_role.stepfunction_role.arn
    definition = data.template_file.sfn_transaction.rendered

    logging_configuration {
      log_destination = "${aws_cloudwatch_log_group.this.arn}:*"
      include_execution_data = true
      level = "ERROR"
    }
}
