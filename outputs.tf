output "lambda_bucket_name" {
  description = "Name of the S3 bucket used to store function code."
  value       = module.AWS.s3_bucket_name
}

output "api_deployment_url" {
  description = "Deployment API URL"
  value       = "${module.AWS.api_deployment_url}/${var.apigw_path}"
}

# output "function_name" {
#   description = "Name of the Lambda function."

#   value = aws_lambda_function.lambda_function[count.index].function_name
# }
