# iam_load_balancer_controller.tf

data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "aws_load_balancer_controller" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "IAM policy for AWS Load Balancer Controller"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:CreateServiceLinkedRole",
          "iam:GetPolicy",
          "iam:ListPolicies",
          "iam:DeleteServiceLinkedRole",
          "iam:GetServiceLinkedRole",
          "ec2:DescribeTags",
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeAddresses",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets",
          "ec2:DescribeRouteTables",
          "ec2:DescribeSecurityGroups",
          "ec2:CreateSecurityGroup",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:RevokeSecurityGroupIngress",
          "ec2:DeleteSecurityGroup",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeClassicLoadBalancers",
          "ec2:DescribeLoadBalancerAttributes",
          "ec2:DescribeLoadBalancers",
          "ec2:CreateLoadBalancer",
          "ec2:ModifyLoadBalancerAttributes",
          "ec2:DeleteLoadBalancer",
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "ec2:DescribeTargetGroups",
          "ec2:CreateTargetGroup",
          "ec2:DeleteTargetGroup",
          "ec2:ModifyTargetGroupAttributes",
          "ec2:DescribeTargetHealth",
          "ec2:RegisterTargets",
          "ec2:DeregisterTargets",
          "ec2:DescribeListeners",
          "ec2:CreateListener",
          "ec2:ModifyListener",
          "ec2:DeleteListener",
          "ec2:DescribeListenerCertificates",
          "ec2:AddListenerCertificates",
          "ec2:RemoveListenerCertificates",
          "acm:DescribeCertificate",
          "acm:ListCertificates",
          "acm:GetCertificate",
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets",
          "route53:ListHostedZones"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "aws_load_balancer_controller" {
  name = "aws-load-balancer-controller-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${aws_eks_cluster.demo.identity[0].oidc[0].issuer}"
        }
        Condition = {
          StringEquals = {
            "${aws_eks_cluster.demo.identity[0].oidc[0].issuer}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_load_balancer_controller" {
  role       = aws_iam_role.aws_load_balancer_controller.name
  policy_arn = aws_iam_policy.aws_load_balancer_controller.arn
}