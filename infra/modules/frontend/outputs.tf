output "bucket_name" {
  value       = aws_s3_bucket.frontend.bucket
  description = "S3 bucket name for the static website"
}

output "website_endpoint" {
  value       = local.website_endpoint
  description = "S3 website endpoint"
}

output "website_domain" {
  value       = local.website_endpoint
  description = "S3 website domain"
}
