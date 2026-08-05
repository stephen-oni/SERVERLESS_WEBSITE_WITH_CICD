# 1. Create the S3 Bucket for the static website files.
resource "aws_s3_bucket" "my_static_bucket" {
  # Utilizes the variable defined in variables.tf
  bucket = var.bucket_name
}

# 2. Block all direct public access to the S3 bucket.
# Security best practice: All traffic must route through CloudFront.
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.my_static_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# 3. Create the CloudFront Origin Access Control (OAC).
# This is the modern standard for authenticating CloudFront with an S3 bucket securely.
resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.bucket_name}-oac"
  description                       = "OAC for S3 static resume"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# 4. Create the CloudFront Distribution.
resource "aws_cloudfront_distribution" "my_distribution" {
  enabled             = true
  # Determines the default file to load when users hit the base URL
  default_root_object = "index.html"

  origin {
    # Uses the regional domain name for optimal internal AWS routing speed
    domain_name              = aws_s3_bucket.my_static_bucket.bucket_regional_domain_name
    origin_id                = "MyS3Origin"
    # Attaches the OAC created above to this origin
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    target_origin_id       = "MyS3Origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    # Disables forwarding of query strings and cookies to S3 to improve cache hit rates
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  # Restrictions block is a mandatory requirement in Terraform for CloudFront
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Configures HTTPS delivery using the default *.cloudfront.net SSL certificate
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# 5. Create the S3 Bucket Policy allowing CloudFront to access objects.
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.my_static_bucket.id

  # Uses jsonencode to safely build the required IAM policy syntax
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.my_static_bucket.arn}/*",
        Condition = {
          StringEquals = {
            # Ensures ONLY the specific CloudFront distribution created above can read the files
            "AWS:SourceArn" = aws_cloudfront_distribution.my_distribution.arn
          }
        }
      }
    ]
  })
}