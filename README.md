# SimpleCRMAPI
A simple CRM API that manages operations and allows users to list, create, update, and delete customer entries.

## Infrastructure
![ alt text for screen readers](https://github.com/gowithkk/SimpleCRMAPI/blob/main/Image/SimpleCRMAPI-Architecture.png) 

## Description
This SimpleCRMAPI creates the following resources in AWS using Terraform. When executing terraform deploy:
* SimpleCRMAPI creates
     * Custom IAM policy and roles
     * API Gateway with a single resource "/Custoemrs" and HTTP Methods
     * 4 Lambda functions that support GET, POST, DELETE, and PATCH
     * A DynamoDB with the name SimpleCRM
     * CloudWatch Logs for Lambda and API Gateway, and Metric Alarms for Lambda and DynamoDB
     * S3 bucket
* SimpleCRMAPI also zips python source code and uploads zip files to S3 bucket in support of Lambda functions.
* Once deployment is completed, the following display as outputs:
     * S3 bucket name
     * API endpoint URL

## Documentation for API Endpoints

All URIs are relative to SimpleCRMAPI-OAS.yaml or https://app.swaggerhub.com/apis/k55846/SimpleCRMAPI/1.0.0

HTTP request | Request Body | Response Body | Description
------------ | ------------- | ------------- | ------------- 
**GET** /Customers  | None | Array of Customers | Lists all the customers info, cluding customer id as id, first name as fisrtName, last name as lastName, and address.
**POST** /Customers | Customers | None | Adds a new customer
**PATCH** /Customers | Customers | None | Updates an existing customer&#39;s info
**DELETE** /Customers | ID | None |  Deletes an exisitng customer by its ID

## Usage

Please ensure you have AWS CLI and [Admin Profile](https://docs.aws.amazon.com/polly/latest/dg/setup-aws-cli.html) configured before running SimpleCRMAPI. Your admin profile should have certain permissions to create IAM role and policy, API Gateway, Lambda, DynamoDB, CloudWatch Log and Alarms.

To run this SimpleCRMAPI please execute:

```
git clone https://github.com/gowithkk/SimpleCRMAPI.git
```

```bash
cd SimpleCRMAPI
terraform workspace new dev
terraform init
terraform plan --var-file="dev.tfvars"
terraform apply --var-file="dev.tfvars"
```

Note that this project may create resources which cost money. Run `terraform destroy --var-file="dev.tfvars"` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.48.0 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2.0 |

## Assumptions & Specifications
 * User authentication is not required. API Gateway in this project has been set to No Auth.
 * Each customer has a unique customer id to avoid conflicts. User "id" must be included in the HTTP body when creating, updating, and deleting customer entries in DynamoDB.
 * Terraform state is managed locally as this requires a dynamoDB table and S3 bucket pre-deifined. However, if you plan to manage state using state lock with S3 and dynamoDB, feel free to uncomment line 19~26 in main.tf and change the values to match your DB name and S3 bucket name.
 * Security Consideration
     * VPC
          * For security concerns, having lambda functions deployed in private subnets in a VPC is recommended. However, due to the simplicity of this project, no VPC is created and utilized in this case. Reasons are as below: 
               * In this project, interactions between Lambda functions, API Gateway, and DynamoDB are controlled and protected by IAM roles.
               * Only necessary permissions have been assigned to AWS resources for security reasons.
               * For future development, if the Lambda functions need to access other resources, such as EC2 instances, RDS instances, or other AWS resources running inside a VPC, then it is recommended to place Lambda functions inside of the VPC. Access to DynamoDB, resources in other VPC, or public internet can be granted by a VPC endpoint or a NAT Gateway.
     * IAM
          * API Gateway
               * api_gateway_cloudwatch_global role is assigned to API Gateway to allow API to create log stream and pug logs to CloudWatch.
               * Each API method has been given permission to invoke relevant Lambda functions.
          * Lambda
               * A custom role called serverless_lambda is assigned to Lambda. This role is to allow the following actions to resoureces:
                    * Write CloudWatch Logs 
                    * Read & Write DynamoDB 
                    * Read & Write S3 Objects
     * Logging
          * API Gateway
               * Lgging level has been set to INFO and all relevant logs can be found under in CloudWatch Log Groups.
          * Lambda
               * CloudWatch generates log group for Lambda upon lambda function execution.
          * DynamoDB
               * CloudTrail records any events on a DyanmoDB table. However, CloudTrail is not enabled.
     * Alarms
          * DynamoDB
               * CloudWatch alarms when cunsumed read capacity units of DynamoDB table reach certain point (currently, the threshold is set to 1000). Please note that this is an approx number and can be changed as required.
          * Lambda
               * CloudWatch alarms when a single error occurs on any lambda functions.


## Justification
* DynamoDB 
capacity mode is set to On-demand. This is to save cost by paying for the actual reads and writes the application performs.
In this mode, auto scaling is enabled by default. 

* Lambda 
lambda suppport auto scaling with no additional cost

* API gateway 
allows for up to 10,000 requests per second and will scale in response to a large burst of traffic.

## Author
Kai Liu | liuky008@gmail.com