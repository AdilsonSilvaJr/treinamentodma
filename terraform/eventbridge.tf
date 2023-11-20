locals {
  domain = "treinamentodma"
  tags = {
    team-email = "teamdma@gmail.com"
    owner-email = "treinamentodma@gmail.com"
  }
}

resource "aws_cloudwatch_event_rule" "this" {
  name = local.stepfunction_name
  event_pattern = 
  is_enabled = true
  tags = local.tags
}