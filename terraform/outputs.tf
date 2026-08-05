# Defines the specific data Terraform will return after successful execution.
# GitHub Actions will extract these values to automate the app deployment.

output "s3_bucket_name" {
  # Passed to 'aws s3 sync' to know exactly which bucket to upload index.html to
  value = aws_s3_bucket.my_static_bucket.id
}

output "cloudfront_distribution_id" {
  # Passed to 'aws cloudfront create-invalidation' to clear the edge caches after an update
  value = aws_cloudfront_distribution.my_distribution.id
}

output "cloudfront_url" {
  # Prints the final public URL of your website to the terminal output
  value = aws_cloudfront_distribution.my_distribution.domain_name
}