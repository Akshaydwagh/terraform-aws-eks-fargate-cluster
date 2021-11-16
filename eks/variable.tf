variable "cluster_name" {
  default = "demo"
}

variable "environment" {
 default = "test"
}

variable "eks_node_group_instance_types" {
   default = "nord"
}


variable "private_subnets" {
   default = "yeah"
}

variable "public_subnets" {
   default = "verr"
}

variable "fargate_namespace" {
  default = "fgt"
}
