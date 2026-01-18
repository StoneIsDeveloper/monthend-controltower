variable "project_name" {
  type        = string
  description = "Project name used for resource naming"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "advancer_lambda_arn" {
  type        = string
  description = "Advancer lambda ARN"
}

variable "advancer_lambda_name" {
  type        = string
  description = "Advancer lambda name"
}
