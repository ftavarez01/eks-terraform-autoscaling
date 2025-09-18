# Creating a SG for the ALB from kubecost OR opencost
resource "aws_security_group" "kubecost_alb_sg" {
  name_prefix = "kubecost-alb-sg-"
  vpc_id      = aws_vpc.k8s-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir HTTP desde cualquier lugar"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir HTTPS desde cualquier lugar"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kubecost-alb-sg"
  }
}

#Allow Traffic fof SG to for permit traffic since ALB
resource "aws_security_group_rule" "allow_alb_to_eks_cluster" {
  type                     = "ingress"
  from_port                = 9090 # Kubecost port service
  to_port                  = 9090
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.kubecost_alb_sg.id
  security_group_id        = aws_eks_cluster.demo.vpc_config[0].cluster_security_group_id
}