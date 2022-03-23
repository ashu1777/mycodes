provider "google" {
  project = "spring-boot-bootstrap-project"
  region  = "us-central1"
  credentials = file("/Users/ashutoshgautam/Downloads/test.json")
}
module "service-accounts" {
  source  = "./service_account"
  project_id = "spring-boot-bootstrap-project"
  project_roles=["roles/"]
  names=["mukul-sva"]
  # insert the 1 required variable here
}
output "haggu-name" {
  value = module.service-accounts.service_account
}