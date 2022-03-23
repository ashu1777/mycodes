variable "cluster_name" {
  default = "terraform-eks-demo"
  type    = string
}

variable "vpc_subnet" {
  type    = list
}


variable "eks_cluster_version" {
  type    = string
}

variable "eks_cluster_tags" {
  type = map
  default = {}
}

variable "node_group_name" {
  type    = string
}

variable "instance_type" {
  type    = list(string)
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "scale_min_size" {
  type    = number
  default = 2
}

variable "scale_max_size" {
  type    = number
  default = 5
}

variable "scale_desired_size" {
  type    = number
  default = 3
}

variable "node_sg" {
  type    = list
}

variable "ssh_key" {
  type    = string
}

variable "node_group_role_name" {
  type    = string
}

