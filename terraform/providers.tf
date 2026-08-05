# Configures the core Terraform settings and required plugins.
terraform {
  required_providers {
    aws = {
      # Specifies the official HashiCorp AWS provider
      source  = "hashicorp/aws"
      # Pins the provider version to 5.x to prevent breaking changes in the future
      version = "~> 5.0"
    }
  }
}

# Configures the AWS provider settings.
provider "aws" {
  # Sets the default region where the AWS resources will be created
  region = "us-east-1"
}
