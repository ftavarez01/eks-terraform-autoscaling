# Create a VPC
resource "aws_vpc" "k8s-vpc" {
  cidr_block = "10.10.0.0/16"
  tags = {
    Name = "k8s-vpc"
  }
}