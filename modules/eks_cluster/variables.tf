variable "eks-cluster-name" {
  type    = string
  default = ""
}

variable "cluster_role_name" {
  description = "Role Name of cluster"
  default     = ""
}
variable "node_role_name" {
  description = "Role Name of Node"
  default     = ""

}
variable "node_group_name" {
  description = "Name of Node Group"
  default     = ""
}

variable "security_group_name" {
  description = "The name of EKS Cluster Security Group"
  default     = ""
}

variable "public_subnet" {}

variable "private_subnet" {}

variable "vpc" {}

variable "tags" {}

variable "key" {}
variable "security_group" {}