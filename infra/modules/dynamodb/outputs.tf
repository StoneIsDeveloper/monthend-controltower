output "table_name" {
  value       = aws_dynamodb_table.monthend_progress.name
  description = "DynamoDB table name"
}

output "table_arn" {
  value       = aws_dynamodb_table.monthend_progress.arn
  description = "DynamoDB table ARN"
}
