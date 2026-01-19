variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
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
