variable "cluster_name" {}
variable "cluster_version" {}
variable "subnet_ids" {
  type = list(string)
}
variable "node_role_arn" {}
variable "key_pair_name" {}
