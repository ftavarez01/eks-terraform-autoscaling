resource "aws_eks_addon" "aws_ebs_csi_driver" {
  cluster_name                = aws_eks_cluster.demo.name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = "v1.32.0-eksbuild.1" # 👈 Versión correcta para EKS 1.32
  service_account_role_arn    = aws_iam_role.ebs_csi_driver_role.arn
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

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
