locals {
  domain_name = "mycluster"
  version     = "7.1"

  cluster_config = {
    dedicated_master_enabled = true
    instance_count           = 3
    instance_type            = "r5.large.elasticsearch"
    zone_awareness_enabled   = true
    availability_zone_count  = 3
  }
  ebs_options = {
    ebs_enabled = "true"
    volume_size = "25"
  }
  encrypt_at_rest = {
    enabled    = true
    kms_key_id = "arn:aws:kms:us-east-1:123456789101:key/cccc103b-4ba3-5993-6fc7-b7e538b25fd8"
  }

  log_publishing_options = {
    enabled  = true
    log_type = "INDEX_SLOW_LOGS"
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = true
  }
  node_to_node_encryption_enabled                = true
  snapshot_options_automated_snapshot_start_hour = 23


  tags = {
    Owner = "sysops"
    env   = "dev"
  }
}