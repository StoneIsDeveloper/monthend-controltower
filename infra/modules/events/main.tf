locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

resource "aws_cloudwatch_event_rule" "step_approved" {
  name        = "${local.name_prefix}-step-approved"
  description = "Triggers when a month-end step is approved"

  event_pattern = jsonencode({
    source        = ["monthend.controltower"],
    "detail-type" = ["MonthEndStepApproved"]
  })
}

resource "aws_cloudwatch_event_target" "advancer" {
  rule      = aws_cloudwatch_event_rule.step_approved.name
  target_id = "advancer"
  arn       = var.advancer_lambda_arn
}

resource "aws_lambda_permission" "allow_events" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.advancer_lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.step_approved.arn
}
