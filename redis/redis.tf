#locals {
#  passwd             = ""
#  vpc                = ""
#  subscription_name  = ""
#  ntw_deploy_cidr    = ""
#  database_name      = ""
#  region             = ""
#}

terraform {
 required_providers {
   rediscloud = {
     source   = "RedisLabs/rediscloud"
     version  = "0.2.0"
   }
 }
}

#data "rediscloud_payment_method" "card" {
#  card_type = "Visa"
#}

#rediscloud_cloud_account      data source
# resource "rediscloud_cloud_account" "redis_acc" {
#   access_key_id     = "abcdefg"
#   access_secret_key = "9876543"
#   console_username  = "username"
#   console_password  = "password"
#   name              = "Example account"
#   provider_type     = "GCP"
#   sign_in_login_url = "https://app.redislabs.com/api/v1/gcp/authenticate"  
# }

#rediscloud-database
resource "rediscloud_subscription" "redis_subs" {

  name                  = var.subscription_name
  payment_method_id     = data.rediscloud_payment_method.card.id   #optional
  memory_storage        = "ram"     #optional . DEFAULT=ram or ram-and-flash
  # allowlist will be using if (cloud_account_id != 1)
  allowlist {    
     cidrs              = ""      #to be given
     security_group_ids = ""      # to SEE AFTERWARDS
  }

  cloud_provider {
    provider                      = var.provider              # rediscloud_cloud_account.redis_acc.provider_type  
    cloud_account_id              = rediscloud_cloud_account.redis_acc.id  # needs to be inputted for redis_cloud account
    region {
      region                      = var.region   #"asia-south-1"               #if req. change it
      multiple_availability_zones = true         #optional 
      networking_vpc_id           = var.vpc                 #optional 
      networking_deployment_cidr  = var.ntw_deploy_cidr       #change it
      preferred_availability_zones= ["asia-south-1a","asia-south-1b","asia-south-1c"]    #reqiured to change it
    }
  }

  database {
    name                          = var.database_name
    protocol                      = "redis"     # or memcached optional
    memory_limit_in_gb            = 20    #10-20 gb
    support_oss_cluster_api       = false  #DEFAULT =FALSE optional   after console part
    external_endpoint_for_oss_cluster_api= false   #DEFAULT =FALSE optional
    periodic_backup_path          = ""   #optional
    replica_of                    = ""     #format= redis://user:password@host:port    Optional
    replication                   =  true # DEFAULT=true
    data_persistence              = "none"  #Optional
    throughput_measurement_by     = "operations-per-second"
    throughput_measurement_value  = 10000
    password                      = var.passwd
    #Optional
    alert {
      name   = "dataset-size"
      value  = 15
    }
  }
}


#rediscloud_subscription_peering
# #redis_peering
# resource "rediscloud_subscription_peering" "redis_peering" {
#    subscription_id = rediscloud_subscription.redis_subs.id
#    provider = var.provider    #"GCP"
#    gcp_project_id = "cloud-api-123456"
#    gcp_network_name = "cloud-api-vpc-peering"
# }

data "google_compute_network" "network" {
  project = var.project    # GCP project ID that the VPC to be peered 
  name = ""                # The name of the network to be peered
}
#google peering
resource "rediscloud_subscription_peering" "redis_peering" {
  subscription_id = rediscloud_subscription.example.id
  provider_name = var.provider        #"GCP"
  gcp_project_id = data.google_compute_network.network.project
  gcp_network_name = data.google_compute_network.network.name
}

resource "google_compute_network_peering" "redis-gcp-peering" {
  name         = "peering-gcp"
  network      = data.google_compute_network.network.self_link
  gcp_redis_project_id=""
  gcp_redis_network_name=""
  peer_network = "https://www.googleapis.com/compute/v1/projects/${rediscloud_subscription_peering.redis_peering.gcp_redis_project_id}/global/networks/${rediscloud_subscription_peering.redis_peering.gcp_redis_network_name}"
}




