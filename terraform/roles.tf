# Role Crawler
resource "aws_iam_role" "crawler_role" {
  name               = "crawler_Function_Role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "glue.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}
# Policy Crawler
resource "aws_iam_policy" "iam_policy_for_crawler" {

  name        = "aws_iam_policy_aws_crawler_role"
  path        = "/"
  description = "AWS IAM Policy for managing aws crawler role"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::treinamentodma-077169358277-silver*"
            ]
        }
    ]
}
EOF
}
# Attach role and policy Crawler
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  for_each = toset([
    "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole",
    "arn:aws:iam::077169358277:policy/aws_iam_policy_aws_crawler_role"
  ])

  role       = aws_iam_role.crawler_role.name
  policy_arn = each.value
  depends_on = [aws_iam_policy.iam_policy_for_crawler]

}
# Role Stepfunction
resource "aws_iam_role" "stepfunction_role" {
  name               = "stepfunction_Role"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "states.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}
# Policy Stepfunction
resource "aws_iam_policy" "policy_stepfunction" {
  name = "LambdaFunctionInvocationPolicy"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction",
                "lambda:InvokeAsync"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
# Attach role and policy Stepfunction
resource "aws_iam_role_policy_attachment" "iam_for_sfn_attach" {
  role       = aws_iam_role.stepfunction_role.name
  policy_arn = aws_iam_policy.policy_stepfunction.arn
}
