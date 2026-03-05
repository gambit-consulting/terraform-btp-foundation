# ============================================================================
# Subaccount Outputs
# ============================================================================

output "subaccount_id" {
  description = "The ID of the created BTP subaccount"
  value       = module.subaccount.id
}

output "subaccount_name" {
  description = "The name of the created BTP subaccount"
  value       = module.subaccount.name
}

output "subaccount_subdomain" {
  description = "The subdomain of the created BTP subaccount"
  value       = module.subaccount.subdomain
}

output "custom_ias_trust_origin" {
  description = "Origin of the custom IAS trust configuration (if enabled)"
  value       = module.subaccount.custom_ias_trust_origin
}

# ============================================================================
# Cloud Foundry Outputs (Optional)
# ============================================================================

output "cloudfoundry_labels" {
  description = "Labels from Cloud Foundry environment instance (JSON string, if enabled)"
  value       = module.subaccount.cloudfoundry_labels
}

output "cloudfoundry_landscape_label" {
  description = "Landscape label from Cloud Foundry environment (if enabled)"
  value       = module.subaccount.cloudfoundry_landscape_label
}

# ============================================================================
# Integration Suite Outputs (Optional)
# ============================================================================

output "integrationsuite_entitlement_id" {
  description = "ID of the Integration Suite entitlement (if enabled)"
  value       = try(module.integrationsuite[0].entitlement_id, null)
}

output "integrationsuite_entitlement_state" {
  description = "State of the Integration Suite entitlement (OK/PROCESSING/FAILED)"
  value       = try(module.integrationsuite[0].entitlement_state, null)
}

output "integrationsuite_subscription_id" {
  description = "ID of the Integration Suite subscription (if enabled)"
  value       = try(module.integrationsuite[0].subscription_id, null)
}

output "integrationsuite_subscription_url" {
  description = "URL to access Integration Suite (if enabled)"
  value       = try(module.integrationsuite[0].subscription_url, null)
}

output "integrationsuite_subscription_state" {
  description = "State of the Integration Suite subscription (SUBSCRIBED/NOT_SUBSCRIBED)"
  value       = try(module.integrationsuite[0].subscription_state, null)
}

output "integrationsuite_service_name" {
  description = "The Integration Suite service name used (if enabled)"
  value       = try(module.integrationsuite[0].service_name, null)
}

output "integrationsuite_plan_name" {
  description = "The Integration Suite plan name used (if enabled)"
  value       = try(module.integrationsuite[0].plan_name, null)
}
