   
variable provider {
  type        = string
  description = "The name of the provider"
}

variable vpc_name {
  type        = string
  description = "The name of the VPC in which the redis is to be created"
}

variable subscription_name {
  type        = string
  description = "The name of the redis-subscription to be created "
}

variable ntw_deploy_cidr {
  type        = string
  description = "The cidr value of the network in which redis to be created"
}

variable region {
  type        = string
  description = "The region where our project is created"
}

variable project {
  type        = string
  description = "The name of the project"
}

variable passwd {
  type        = string
  description = "The password for the database"
}