output "subaccount_id" {
  description = "The ID of the created subaccount"
  value       = module.subaccount.id
}

output "subaccount_subdomain" {
  description = "The subdomain of the created subaccount"
  value       = module.subaccount.subdomain
}

output "subaccount_name" {
  description = "The name of the created subaccount"
  value       = module.subaccount.name
}

output "custom_ias_origin" {
  description = "Origin of the custom IAS trust configuration (if enabled)"
  value       = module.subaccount.custom_ias_trust_origin
}

output "cloudfoundry_landscape" {
  description = "Cloud Foundry landscape label (if enabled)"
  value       = module.subaccount.cloudfoundry_landscape_label
}
