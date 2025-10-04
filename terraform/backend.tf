# backend.tf (Archivo en tu repositorio principal)
terraform {
  backend "s3" {
    bucket = "my-terraform-tfplan"
    key    = "terraform.tfstate"
    region = "us-east-2"
    #dynamodb_table = "terraform-lock-table"
  }
}