# role for nodegroup

resource "aws_iam_role" "nodes" {
  name = "eks-node-group-nodes"

  assume_role_policy = jsonencode({
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = [
          "ec2.amazonaws.com",
          "eks.amazonaws.com"
        ]
      }
    }]
    Version = "2012-10-17"
  })
}

# IAM policy attachment to nodegroup

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes.name
}

resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes.name
}

# aws node group 

resource "aws_eks_node_group" "private-nodes" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = "private-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    aws_subnet.private-us-east-2a.id,
    aws_subnet.private-us-east-2b.id
  ]

  capacity_type  = "ON_DEMAND"
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    type = "on-demand" 
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}

# AWS node group - SPOT

resource "aws_eks_node_group" "spot-nodes" {
  cluster_name    = aws_eks_cluster.demo.name
  node_group_name = "spot-nodes"
  node_role_arn   = aws_iam_role.nodes.arn

  subnet_ids = [
    aws_subnet.private-us-east-2a.id,
    aws_subnet.private-us-east-2b.id
  ]

  capacity_type  = "SPOT"
  instance_types = ["t3.medium", "t3.small"] # Instance Type more flexibility

  scaling_config {
    desired_size = 0
    max_size     = 3
    min_size     = 0
  }

  labels = {
    type = "spot" # Correct syntax
    node = "important"
  }

  tags = {
    "k8s.io/cluster-autoscaler/enabled" = "true"
    "k8s.io/cluster-autoscaler/demo"    = "owned"
    "kubernetes.io/cluster/demo"        = "owned"
  }

  depends_on = [
    aws_iam_role_policy_attachment.nodes-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodes-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodes-AmazonEC2ContainerRegistryReadOnly,
  ]
}