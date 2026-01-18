output "dynamodb_table_name" {
  value       = module.dynamodb.table_name
  description = "DynamoDB table name"
}

output "api_endpoint" {
  value       = module.api.api_endpoint
  description = "HTTP API endpoint"
}

output "frontend_bucket_name" {
  value       = module.frontend.bucket_name
  description = "S3 bucket name for the static website"
}

output "frontend_website_endpoint" {
  value       = module.frontend.website_endpoint
  description = "S3 website endpoint"
}

output "advancer_event_rule_arn" {
  value       = module.events.rule_arn
  description = "EventBridge rule ARN for step advancement"
}
