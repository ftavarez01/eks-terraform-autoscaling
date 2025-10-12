data "aws_iam_policy_document" "ebs_csi_driver_trust_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${trimprefix(aws_eks_cluster.demo.identity[0].oidc[0].issuer, "https://")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }
  }
}

resource "aws_iam_role" "ebs_csi_driver_role" {
  name               = "${aws_eks_cluster.demo.name}-EBS-CSI-Driver-Role"
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_driver_trust_policy.json
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attach" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" # ✅ Correcto
  role       = aws_iam_role.ebs_csi_driver_role.name
}
