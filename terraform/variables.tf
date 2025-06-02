variable "aws_region" {
  default = "us-east-2"
}

variable "cluster_name" {
  default = "ecomm-eks-cluster"
}

variable "key_pair_name" {
  description = "Your EC2 Key Pair name"
  default     = "linux"
}
