/*
# Providers AWS and necesary verson and regions.
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.29.0"
    }
  }
}

provider "aws" {
  # Configuration options
   region = var.region
}
*/

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
  region                   = "us-east-2"
  shared_config_files      = ["/home/fsociety/.aws/config"]
  shared_credentials_files = ["/home/fsociety/.aws/credentials"]
  profile                  = "default"
}