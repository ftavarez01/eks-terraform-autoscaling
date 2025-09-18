resource "aws_eks_addon" "aws_ebs_csi_driver" {
  cluster_name                = aws_eks_cluster.demo.name
  addon_name                  = "aws-ebs-csi-driver"
  resolve_conflicts_on_create = "OVERWRITE"

  tags = {
    "addon-source" = "terraform"
  }
}

# Addons gestionados por Terraform
resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = aws_eks_cluster.demo.name
  addon_name                  = "vpc-cni"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = aws_eks_cluster.demo.name
  addon_name                  = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = aws_eks_cluster.demo.name
  addon_name                  = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
}
