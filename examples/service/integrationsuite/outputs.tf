output "subaccount_id" {
  description = "The ID of the created subaccount"
  value       = module.subaccount.id
}

output "subaccount_subdomain" {
  description = "The subdomain of the created subaccount"
  value       = module.subaccount.subdomain
}

output "entitlement_id" {
  description = "ID of the Integration Suite entitlement"
  value       = module.integration_suite.entitlement_id
}

output "entitlement_state" {
  description = "State of the entitlement"
  value       = module.integration_suite.entitlement_state
}

output "subscription_id" {
  description = "ID of the Integration Suite subscription"
  value       = module.integration_suite.subscription_id
}

output "subscription_url" {
  description = "URL to access Integration Suite"
  value       = module.integration_suite.subscription_url
}

output "subscription_state" {
  description = "State of the subscription"
  value       = module.integration_suite.subscription_state
}

output "service_name" {
  description = "The service name used"
  value       = module.integration_suite.service_name
}

output "plan_name" {
  description = "The plan name used"
  value       = module.integration_suite.plan_name
}
