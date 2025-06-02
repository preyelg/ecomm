module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "ecomm-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true

  map_public_ip_on_launch = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.8.4"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  eks_managed_node_groups = {
    default = {
      desired_size   = var.desired_capacity
      max_size       = var.max_capacity
      min_size       = var.min_capacity

      instance_types = ["t3.medium"]
      key_name       = var.key_pair_name
    }
  }

  enable_irsa = true
}
