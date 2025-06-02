variable "cluster_name" {}
variable "cluster_version" {}
variable "subnet_ids" {
  type = list(string)
}
variable "node_role_arn" {
    description = "IAM role ARN for worker nodes"
    type = string
}
variable "key_pair_name" {}
