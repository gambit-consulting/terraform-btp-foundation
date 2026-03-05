output "id" {
  description = "The ID of the BTP subaccount"
  value       = btp_subaccount.this.id
}

output "subdomain" {
  description = "The subdomain of the BTP subaccount"
  value       = btp_subaccount.this.subdomain
}

output "name" {
  description = "The name of the BTP subaccount"
  value       = btp_subaccount.this.name
}

output "custom_ias_trust_origin" {
  description = "Origin of the custom IAS trust configuration"
  value       = try(btp_subaccount_trust_configuration.custom_ias[0].origin, null)
}

output "cloudfoundry_labels" {
  description = "Labels from Cloud Foundry environment (as JSON string)"
  value       = try(btp_subaccount_environment_instance.cloudfoundry[0].labels, null)
}

output "cloudfoundry_landscape_label" {
  description = "Landscape label from Cloud Foundry environment"
  value       = try(btp_subaccount_environment_instance.cloudfoundry[0].landscape_label, null)
}
