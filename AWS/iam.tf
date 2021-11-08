resource "aws_iam_role" "lambda_exec" {
  name = "serverless_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Sid    = ""
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      }
    ]
  })
}

data "template_file" "customer_lambda_policy" {
  template = file("${path.module}/policy.json")
}

resource "aws_iam_policy" "customer_lambda_policy" {
  name        = "CustomerLambdaPolicy"
  path        = "/"
  description = "IAM Policy for Customer Lambda Functions"
  policy      = data.template_file.customer_lambda_policy.rendered
}

resource "aws_iam_role_policy_attachment" "customer_lambda_policy_bidning" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.customer_lambda_policy.arn
}