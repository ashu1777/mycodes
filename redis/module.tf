module "redis" {
    source             = "../redis"
    provider           = "GCP"
    vpc_name           = ""
    subscription_name  = ""
    ntw_deploy_cidr    = ""
    database_name      = ""
    region             = ""
    project            = ""
    passwd             = ""
}
