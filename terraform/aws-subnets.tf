# Creating Subnets Private and Public
# private subnet 01

resource "aws_subnet" "private-us-east-2a" {
  vpc_id            = aws_vpc.k8s-vpc.id
  cidr_block        = "10.10.0.0/19"
  availability_zone = "us-east-2a"

  tags = {
    Name                              = "private-us-east-2a"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}
# private subnet 02

resource "aws_subnet" "private-us-east-2b" {
  vpc_id            = aws_vpc.k8s-vpc.id
  cidr_block        = "10.10.32.0/19"
  availability_zone = "us-east-2b"

  tags = {
    Name                              = "private-us-east-2b"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

# public subnet 01

resource "aws_subnet" "public-us-east-2a" {
  vpc_id                  = aws_vpc.k8s-vpc.id
  cidr_block              = "10.10.64.0/19"
  availability_zone       = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    Name                         = "public-us-east-2a"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}
# public subnet 02

resource "aws_subnet" "public-us-east-2b" {
  vpc_id                  = aws_vpc.k8s-vpc.id
  cidr_block              = "10.10.96.0/19"
  availability_zone       = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    Name                         = "public-us-east-2b"
    "kubernetes.io/role/elb"     = "1"
    "kubernetes.io/cluster/demo" = "owned"
  }
}