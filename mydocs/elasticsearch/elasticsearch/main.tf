resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "elastic" {
    
    #count = var.enabled ? 1 : 0

    domain_name = var.domain_name
    elasticsearch_version = var.elasticsearch_version
    access_policies = var.access_policies

    advanced_options = var.advanced_options == null ? {} : var.advanced_options

    advanced_security_options {

        enabled  = var.advanced_security_options_enabled != "false" ? "true" : "false"
        internal_user_database_enabled = var.internal_user_database_enabled
         master_user_options {
            master_user_arn = var.master_user_arn
            master_user_name  = var.master_user_name
            master_user_password = var.master_user_password
         }
    }

    cluster_config {
       dedicated_master_count = var.dedicated_master_count
       dedicated_master_enabled = var.dedicated_master_enabled
       dedicated_master_type = var.dedicated_master_type
       instance_count = var.instance_count
       instance_type = var.instance_type
       zone_awareness_enabled = var.zone_awareness_enabled
       warm_enabled = var.warm_enabled
       warm_count = var.warm_count
       warm_type = var.warm_type
         
         
      zone_awareness_config {

         availability_zone_count  = var.zone_awareness_enabled == true ? var.availability_zone_count : 0
         
        }
    }
    
  
    

    ebs_options {

      ebs_enabled = var.ebs_enabled
      volume_type = var.volume_type
      volume_size = var.volume_size
      iops        = var.iops
    }
   encrypt_at_rest {
     enabled = var.encrypt_at_rest_enabled
     kms_key_id = var.kms_key_id


   }

   log_publishing_options {
      log_type                 = var.log_type
      cloudwatch_log_group_arn = var.cloudwatch_log_group_arn
      enabled                  = var.log_enabled

    }


   node_to_node_encryption {
       enabled = var.node_to_node_encryption_enabled
   }
  snapshot_options {
       automated_snapshot_start_hour = var.snapshot_options_automated_snapshot_start_hour
  }

  vpc_options {
      security_group_ids = var.vpc_options_security_group_ids
      subnet_ids         = var.vpc_options_subnet_ids
    }

  timeouts {
     update = var.timeouts_update
    }

  tags = var.tags

  depends_on = [
    aws_iam_service_linked_role.es,
  ]
 


}
