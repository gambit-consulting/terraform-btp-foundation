output "entitlement_id" {
  description = "ID of the Integration Suite entitlement"
  value       = btp_subaccount_entitlement.this.id
}

output "entitlement_state" {
  description = "State of the entitlement (OK/PROCESSING/FAILED)"
  value       = btp_subaccount_entitlement.this.state
}

output "subscription_id" {
  description = "ID of the Integration Suite subscription"
  value       = btp_subaccount_subscription.this.id
}

output "subscription_url" {
  description = "URL to access Integration Suite (CPI, API Management, etc.)"
  value       = btp_subaccount_subscription.this.subscription_url
}

output "subscription_state" {
  description = "State of the subscription (SUBSCRIBED/NOT_SUBSCRIBED)"
  value       = btp_subaccount_subscription.this.state
}

output "service_name" {
  description = "The service name used"
  value       = var.service_name
}

output "plan_name" {
  description = "The plan name used"
  value       = var.plan_name
}
