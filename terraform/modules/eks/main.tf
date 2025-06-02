resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = var.node_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  version = var.cluster_version
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]
  disk_size      = 20

  remote_access {
    ec2_ssh_key = var.key_pair_name
  }

  depends_on = [aws_eks_cluster.eks]
}
