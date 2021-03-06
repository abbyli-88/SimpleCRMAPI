aws_region          = "ap-southeast-2"
dynamodb_table_name = "SimpleCRM"
s3_prefix_name      = "lambda-apigw-integration"
lambda_funtion_name = ["create", "delete", "list", "update"]
api_gateway_name    = "SimpleCRM_apigw"
api_description     = "SimpleCRM API Gateway"
apigw_path          = "Customers"
apigw_method        = ["POST", "DELETE", "GET", "PATCH"]
api_auth            = "NONE"
api_gw_integration  = "AWS"
