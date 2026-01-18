output "rule_arn" {
  value       = aws_cloudwatch_event_rule.step_approved.arn
  description = "EventBridge rule ARN"
}

output "rule_name" {
  value       = aws_cloudwatch_event_rule.step_approved.name
  description = "EventBridge rule name"
}
