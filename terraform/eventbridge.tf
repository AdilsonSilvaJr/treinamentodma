locals {
  domain = "treinamentodma"
  tags = {
    team-email = "teamdma@gmail.com"
    owner-email = "treinamentodma@gmail.com"
  }
}

resource "aws_cloudwatch_event_rule" "this" {
  name = local.stepfunction_name
  event_pattern = <<EOF
  {
  "source": ["aws.s3"],
  "detail-type": ["Object Created"],
  "detail": {
    "bucket": {
      "name": ["treinamentodma-077169358277-bronze"]
    },
    "object": {
      "key": [{
        "prefix": "card-transactions/"
      }]
    }
  }
}
EOF
  is_enabled = true
  tags = local.tags
}

resource "aws_cloudwatch_event_target" "name" {
    rule = aws_cloudwatch_event_rule.this.name
    arn = aws_sfn_state_machine.this.arn
    role_arn = aws_iam_role.eventbridge_role.arn
}