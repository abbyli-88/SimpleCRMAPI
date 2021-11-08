terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.48.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.0"
}

provider "aws" {
  region = var.aws_region
}

module "AWS" {
  source                = "./AWS"
  dynamodb_table_name   = var.dynamodb_table_name
  lambda_funtion_name   = var.lambda_funtion_name
  runtime_type          = "python3.8"
  s3_prefix_name        = var.s3_prefix_name
  archive_source_file   = var.dynamodb_table_name
  api_gateway_name      = var.api_gateway_name
  api_description       = var.api_description
  apigw_path            = var.apigw_path
  apigw_method          = var.apigw_method
  api_auth              = var.api_auth
  api_gw_integration    = var.api_gw_integration
  api_deploy_stage_name = terraform.workspace
}



# module "cloudwatch" {
#      source = ".Modules/CloudWatch"
#      }