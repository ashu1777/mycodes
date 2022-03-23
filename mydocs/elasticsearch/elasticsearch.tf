module "aws_es" {

  source = "./elasticsearch"

  domain_name              = local.domain_name
  elasticsearch_version    = local.version
  dedicated_master_enabled = local.cluster_config.dedicated_master_enabled
  instance_count           = local.cluster_config.instance_count
  instance_type            = local.cluster_config.instance_type
  zone_awareness_enabled   = local.cluster_config.zone_awareness_enabled
  availability_zone_count  = local.cluster_config.availability_zone_count



  ebs_enabled = local.ebs_options.ebs_enabled
  volume_size = local.ebs_options.volume_size



  encrypt_at_rest_enabled = local.encrypt_at_rest.enabled
  kms_key_id              = local.encrypt_at_rest.kms_key_id

  log_enabled = local.log_publishing_options.enabled
  log_type    = local.log_publishing_options.log_type


  advanced_options = local.advanced_options

  node_to_node_encryption_enabled                = local.node_to_node_encryption_enabled
  snapshot_options_automated_snapshot_start_hour = local.snapshot_options_automated_snapshot_start_hour

  tags = local.tags
}