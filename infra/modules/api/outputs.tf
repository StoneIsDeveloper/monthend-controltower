output "api_id" {
  value       = aws_apigatewayv2_api.http_api.id
  description = "HTTP API ID"
}

output "api_endpoint" {
  value       = aws_apigatewayv2_api.http_api.api_endpoint
  description = "HTTP API endpoint"
}

output "api_execution_arn" {
  value       = aws_apigatewayv2_api.http_api.execution_arn
  description = "HTTP API execution ARN"
}

output "api_lambda_arn" {
  value       = aws_lambda_function.api.arn
  description = "API lambda ARN"
}

output "api_lambda_name" {
  value       = aws_lambda_function.api.function_name
  description = "API lambda name"
}

output "api_lambda_role_arn" {
  value       = aws_iam_role.api_lambda.arn
  description = "API lambda IAM role ARN"
}

output "advancer_lambda_arn" {
  value       = aws_lambda_function.advancer.arn
  description = "Advancer lambda ARN"
}

output "advancer_lambda_name" {
  value       = aws_lambda_function.advancer.function_name
  description = "Advancer lambda name"
}

output "advancer_lambda_role_arn" {
  value       = aws_iam_role.advancer_lambda.arn
  description = "Advancer lambda IAM role ARN"
}
