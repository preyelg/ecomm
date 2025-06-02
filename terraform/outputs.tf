output "cluster_name" {
  value = aws_eks_cluster.main.name
}

output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --region=${var.aws_region} --name=${aws_eks_cluster.main.name}"
}
