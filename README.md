# SimpleCRMAPI
A simple CRM API that manages operations and allows users to list, create, update, and delete customer entries.

## Infrastructure

## Usage

To run this SimpleCRMAPI you need to execute:

```bash
$ terraform workspace new dev
$ terraform init
$ terraform plan --var-file="dev.tfvars"
$ terraform apply --var-file="dev.tfvars"
```

Note that this project may create resources which cost money. Run `terraform destroy --var-file="dev.tfvars"` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.48.0 |
| <a name="requirement_archive"></a> [null](#requirement\_null) | >= 2.2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2.0 |


## Documentation for API Endpoints

All URIs are relative to SimpleCRMAPI-OAS.yaml or *https://app.swaggerhub.com/apis/k55846/SimpleCRMAPI/1.0.0

HTTP request | Request Body | Response Body | Description
------------ | ------------- | ------------- | ------------- 
**GET** /Customers  | None | Array of Customers | Lists all the customers info, cluding customer id as id, first name as fisrtName, last name as lastName, and address.
**POST** /Customers | Customers | None | Adds a new customer
**PATCH** /Customers | Customers | None | Updates an existing customer&#39;s info
**DELETE** /Customers | id | None |  Deletes an exisitng customer by its ID



## Documentation For Authorization

 All endpoints do not require authorization.

## Author
Kai Liu | liuky008@gmail.com