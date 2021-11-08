resource "aws_cloudwatch_log_group" "lambda" {
  count             = length(var.lambda_funtion_name)
  name              = "Lambda-${aws_lambda_function.lambda_function[count.index].function_name}"
  retention_in_days = 30
}

#resource "aws_cloudwatch_log_group" "api_gw" {
#     name = "${aws_api_gateway_rest_api.api_gateway_rest.name}"
#    retention_in_days = 30
#}

resource "aws_cloudwatch_log_group" "dynamodb" {
  name              = "${aws_dynamodb_table.dynamodb_table.name}-DynamoDB"
  retention_in_days = 30
}