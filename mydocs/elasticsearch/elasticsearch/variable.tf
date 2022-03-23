variable "domain_name" {
  description = "Name of the domain"
  type        = string
}

variable "elasticsearch_version" {
  description = "The version of Elasticsearch to deploy."
  type        = string
  default     = "7.1"
}

variable "access_policies" {
  description = "IAM policy document specifying the access policies for the domain"
  type        = string
  default     = ""
}

variable "enabled" {
  description = "Change to false to avoid deploying any AWS ElasticSearch resources"
  type        = bool
  default     = true
}

variable "advanced_security_options" {
  description = "Options for fine-grained access control"
  type        = any
  default     = {}
}
variable "advanced_security_options_enabled" {
  description = "Whether advanced security is enabled (Forces new resource)"
  type        = bool
  default     = false
}

variable "internal_user_database_enabled" {
  description = "Whether the internal user database is enabled. If not set, defaults to false by the AWS API."
  type        = bool
  default     = false
}

variable "master_user_arn" {
  description = "ARN for the master user. Only specify if `internal_user_database_enabled` is not set or set to `false`)"
  type        = string
  default     = null
}

variable "master_user_name" {
  description = "The master user's username, which is stored in the Amazon Elasticsearch Service domain's internal database. Only specify if `internal_user_database_enabled` is set to `true`."
  type        = string
  default     = null
}

variable "master_user_password" {
  description = "The master user's password, which is stored in the Amazon Elasticsearch Service domain's internal database. Only specify if `internal_user_database_enabled` is set to `true`."
  type        = string
  default     = null
}
#cluster config option

variable "instance_type" {
  description = "Instance type of data nodes in the cluster"
  type        = string
  default     = "r5.large.elasticsearch"
}

variable "instance_count" {
  description = "Number of instances in the cluster"
  type        = number
  default     = 3
}

variable "dedicated_master_enabled" {
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
  type        = bool
  default     = true
}

variable "dedicated_master_type" {
  description = "Instance type of the dedicated master nodes in the cluster"
  type        = string
  default     = "r5.large.elasticsearch"
}

variable "dedicated_master_count" {
  description = "Number of dedicated master nodes in the cluster"
  type        = number
  default     = 3
}

variable "availability_zone_count" {
  description = "Number of Availability Zones for the domain to use with"
  type        = number
  default     = 3
}

variable "zone_awareness_enabled" {
  description = "Indicates whether zone awareness is enabled. To enable awareness with three Availability Zones"
  type        = bool
  default     = false
}

variable "warm_enabled" {
  description = "Indicates whether to enable warm storage"
  type        = bool
  default     = false
}

variable "warm_count" {
  description = "The number of warm nodes in the cluster"
  type        = number
  default     = null
}

variable "warm_type" {
  description = "The instance type for the Elasticsearch cluster's warm nodes"
  type        = string
  default     = null
}
#ebs options
variable "ebs_enabled" {
  description = "Whether EBS volumes are attached to data nodes in the domain"
  type        = bool
  default     = true
}

variable "volume_type" {
  description = "The type of EBS volumes attached to data nodes"
  type        = string
  default     = "gp2"
}

variable "volume_size" {
  description = "The size of EBS volumes attached to data nodes (in GB). Required if ebs_enabled is set to true"
  type        = number
  default     = 10
}

variable "iops" {
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type"
  type        = number
  default     = 0
}


# encrypt_at_rest


variable "encrypt_at_rest_enabled" {
  description = "Whether to enable encryption at rest"
  type        = bool
  default     = true
}

variable "kms_key_id" {
  description = "The KMS key id to encrypt the Elasticsearch domain with. If not specified then it defaults to using the aws/es service KMS key"
  type        = string
  default     = "alias/aws/es"
}

#node_to_node_encryption
variable "node_to_node_encryption_enabled" {
  description = "Whether to enable node-to-node encryption"
  type        = bool
  default     = true
}

variable "snapshot_options_automated_snapshot_start_hour" {
  description = "Hour during which the service takes an automated daily snapshot of the indices in the domain"
  type        = number
  default     = 0
}

# vpc_options

variable "vpc_options_security_group_ids" {
  description = "List of VPC Security Group IDs to be applied to the Elasticsearch domain endpoints. If omitted, the default Security Group for the VPC will be used"
  type        = list(any)
  default     = []
}

variable "vpc_options_subnet_ids" {
  description = "List of VPC Subnet IDs for the Elasticsearch domain endpoints to be created in"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(any)
  default     = {}
}

variable "timeouts_update" {
  description = "How long to wait for updates."
  type        = string
  default     = null
}

#log options

variable "log_type" {
  description = "A type of Elasticsearch log. Valid values: INDEX_SLOW_LOGS, SEARCH_SLOW_LOGS, ES_APPLICATION_LOGS"
  type        = string
  default     = "INDEX_SLOW_LOGS"
}

variable "cloudwatch_log_group_arn" {
  description = "iARN of the Cloudwatch log group to which log needs to be published"
  type        = string
  default     = ""
}

variable "log_enabled" {
  description = "Specifies whether given log publishing option is enabled or not"
  type        = bool
  default     = true
}

variable "advanced_options" {
  description = "Key-value string pairs to specify advanced configuration options. Note that the values for these configuration options must be strings (wrapped in quotes) or they may be wrong and cause a perpetual diff, causing Terraform to want to recreate your Elasticsearch domain on every apply"
  type        = map(string)
  default     = {}
}