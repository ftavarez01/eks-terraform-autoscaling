
# Providers AWS and necesary verson and regions.#
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
  /*
 backend "s3" {
    bucket = "my-terraform-tfplan" # <-- Directory Backet
    key    = "terraform.tfstate"
    region = "us-east-2"  # <-- Region of your S3 Bucket
  }
  */
}

provider "aws" {
  # Configuration options
  region = var.region
}
