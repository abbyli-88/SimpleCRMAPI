# resource "aws_cloudwatch_log_group" "customer" {
#      count = length(var.lambda_funtion_name)
#      name = "Lambda-${aws_lambda_function.lambda_function[count.index].function_name}"

#      retention_in_days = 30
# }

# resource "aws_cloudwatch_log_group" "api_gw" {
#      name = "api_gw-${aws_api_gateway_rest_api.customer_apigw.name}"

#      retention_in_days = 30
# }
