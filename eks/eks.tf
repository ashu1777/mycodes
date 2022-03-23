provider "aws" {
  region = "ap-south-1"
}

module "eks_cluster" {
  source = "./eks"
  cluster_name = local.cluster_name
  eks_cluster_version = local.k8s_version
  node_group_role_name = local.node_role_name
  vpc_subnet = local.vpc_subnet
 eks_cluster_tags = local.eks_cluster_tags

  node_group_name = local.node_group_name_dev

  instance_type = local.instance_type
  disk_size = local.disk_size

  scale_desired_size = local.scale_desired_size
  scale_max_size = local.scale_max_size
  scale_min_size = local.scale_min_size

  ssh_key = local.ssh_key_pair
  node_sg = local.sg_eks
  
}