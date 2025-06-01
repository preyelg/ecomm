variable "aws_region" {
  description = "AWS region to deploy EKS cluster"
  default     = "us-east-2"
}

variable "cluster_name" {
  description = "EKS Cluster name"
  default     = "ecomm-eks-cluster"
}

variable "key_pair_name" {
  description = "Your existing EC2 key pair name"
  default     = "linux"  // 🔁 replace this
}

variable "desired_capacity" {
  default = 2
}

variable "max_capacity" {
  default = 3
}

variable "min_capacity" {
  default = 1
}
