resource "aws_eip" "natgw" {
  tags = {
    Name = "k8s-natgw"
  }
}

resource "aws_nat_gateway" "k8s-natgw" {
  allocation_id = aws_eip.natgw.id
  subnet_id     = aws_subnet.public-us-east-2a.id

  tags = {
    Name = "k8s-nat"
  }

  depends_on = [aws_internet_gateway.k8s-igw]
}