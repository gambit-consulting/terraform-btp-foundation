# --- Entitlement Outputs ---
output "entitlement_id" {
  description = "ID of the Workzone entitlement"
  value       = btp_subaccount_entitlement.this.id
}

output "entitlement_state" {
  description = "State of the entitlement (OK/PROCESSING/FAILED)"
  value       = btp_subaccount_entitlement.this.state
}

# --- Subscription Outputs ---
output "subscription_id" {
  description = "ID of the Workzone subscription"
  value       = btp_subaccount_subscription.this.id
}

output "subscription_url" {
  description = "URL to access Workzone"
  value       = btp_subaccount_subscription.this.subscription_url
}

output "subscription_state" {
  description = "State of the subscription (SUBSCRIBED/NOT_SUBSCRIBED)"
  value       = btp_subaccount_subscription.this.state
}

# --- Metadata Outputs ---
output "service_name" {
  description = "The service name used"
  value       = var.service_name
}

output "plan_name" {
  description = "The plan name used"
  value       = var.plan_name
}

output "subaccount_id" {
  description = "The subaccount ID where the service is deployed"
  value       = var.subaccount_id
}
