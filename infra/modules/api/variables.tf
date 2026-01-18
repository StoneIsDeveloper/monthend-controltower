variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "lambda_runtime" {
  type        = string
  description = "Lambda runtime"
}

variable "lambda_timeout_seconds" {
  type        = number
  description = "Lambda timeout in seconds"
}

variable "api_lambda_package_path" {
  type        = string
  description = "Path to the API lambda deployment package (placeholder)"
}

variable "advancer_lambda_package_path" {
  type        = string
  description = "Path to the advancer lambda deployment package (placeholder)"
}

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name"
}
