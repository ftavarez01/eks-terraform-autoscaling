resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ${var.region} --name ${aws_eks_cluster.demo.id}"
  }
}