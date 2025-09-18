
# Providers AWS and necesary verson and regions.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.29.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.27.1"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.region
}
