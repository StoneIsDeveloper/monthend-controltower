variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
  default     = "monthend-controltower"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "lambda_runtime" {
  type        = string
  description = "Lambda runtime"
  default     = "nodejs20.x"
}

variable "lambda_timeout_seconds" {
  type        = number
  description = "Lambda timeout in seconds"
  default     = 15
}

variable "api_lambda_package_path" {
  type        = string
  description = "Path to the API lambda deployment package (placeholder)"
  default     = "build/api.zip"
}

variable "advancer_lambda_package_path" {
  type        = string
  description = "Path to the advancer lambda deployment package (placeholder)"
  default     = "build/advancer.zip"
}

variable "country" {
  type        = string
  description = "Country name"
  default     = "China3"
}
