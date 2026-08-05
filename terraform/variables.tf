# Declares input variables so they do not need to be hardcoded into main.tf.
variable "bucket_name" {
  type        = string
  description = "The unique name for your S3 website bucket"
  
  # Enforces S3 naming rules automatically when the variable is provided
  validation {
    condition     = can(regex("^[a-z0-9.-]+$", var.bucket_name))
    error_message = "Bucket name must be lowercase and only contain letters, numbers, dots, or hyphens."
  }
}