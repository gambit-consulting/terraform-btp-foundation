output "subaccount_id" {
  description = "The ID of the created subaccount"
  value       = module.subaccount.id
}

output "subaccount_subdomain" {
  description = "The subdomain of the created subaccount"
  value       = module.subaccount.subdomain
}

output "entitlement_id" {
  description = "ID of the Work Zone entitlement"
  value       = module.workzone.entitlement_id
}

output "entitlement_state" {
  description = "State of the entitlement"
  value       = module.workzone.entitlement_state
}

output "subscription_id" {
  description = "ID of the Work Zone subscription"
  value       = module.workzone.subscription_id
}

output "subscription_url" {
  description = "URL to access Work Zone"
  value       = module.workzone.subscription_url
}

output "subscription_state" {
  description = "State of the subscription"
  value       = module.workzone.subscription_state
}

output "service_name" {
  description = "The service name used"
  value       = module.workzone.service_name
}

output "plan_name" {
  description = "The plan name used"
  value       = module.workzone.plan_name
}
