output "arn" {
  description = "Amazon Resource Name (ARN) of the domain"
  value       = join("", aws_elasticsearch_domain.elastic.*.arn)
}

output "domain_id" {
  description = "Unique identifier for the domain"
  value       = join("", aws_elasticsearch_domain.elastic.*.domain_id)
}

output "endpoint" {
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
  value       = join("", aws_elasticsearch_domain.elastic.*.endpoint)
}

output "kibana_endpoint" {
  description = "Domain-specific endpoint for kibana without https scheme"
  value       = join("", aws_elasticsearch_domain.elastic.*.kibana_endpoint)
}
