
locals {

cluster_name = "zoomcar-eks"
k8s_version =  1.19
vpc_subnet = ["ap-south-1a" , "ap-south-1b" , "ap-south-1c"]
eks_cluster_tags = {
    Name = "eks"
    Env = "dev"
}
node_group_name_dev = "zoomcar_worker_nodes"
instance_type = ["t3.medium"]
disk_size = 30
 scale_desired_size = 1
  scale_max_size = 1
  scale_min_size = 1

  ssh_key_pair = "zoomcar_eks"
  sg_eks = ["sg"]
  node_role_name = "eks_access_role"

}