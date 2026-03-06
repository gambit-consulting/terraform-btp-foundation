# ============================================================================
# Example: Trial Subaccount with Integration Suite (Trial Plan)
# ============================================================================
# This example creates a trial subaccount with SAP Integration Suite enabled.
# Integration Suite provides integration capabilities including:
#   - Cloud Integration (CPI)
#   - API Management
#   - Open Connectors
#   - Integration Advisor
#
# Authentication must be configured via environment variables:
#   export BTP_USERNAME="your-email@example.com"
#   export BTP_PASSWORD="your-password"
#
# Usage:
#   terraform init
#   terraform plan -var-file="terraform.integrationsuite-trial.tfvars"
#   terraform apply -var-file="terraform.integrationsuite-trial.tfvars"
# ============================================================================

# BTP Global Account (REQUIRED - find this in BTP Cockpit)
globalaccount = "my-trial-account-subdomain"

# Subaccount Configuration
name        = "My Trial Subaccount with Integration Suite"
subdomain   = "mycompany-trial-is"
region      = "us10" # Trial-friendly region (alternatives: eu10, ap21)
description = "Trial subaccount with Integration Suite for integration testing"

# Production Flag (trial = false)
is_production = false

# Optional: Contact Information
contact_persons = [
  # "integration-team@example.com"
]

# Optional: Custom Labels
additional_labels = {
  Environment = ["trial"]
  Purpose     = ["integration-testing"]
  Service     = ["integrationsuite"]
}

# Integration Suite Configuration (ENABLED with Trial Plan)
enable_integrationsuite       = true
integrationsuite_service_name = "integrationsuite-trial" # Trial service
integrationsuite_plan_name    = "trial"                  # Trial plan (free tier)
integrationsuite_quota_amount = 1

# Note: For production use, switch to:
#   integrationsuite_service_name = "integrationsuite"
#   integrationsuite_plan_name    = "standard_edition" # or basic_edition, premium_edition

# Optional Features (disabled)
enable_cloudfoundry     = false
enable_custom_ias_trust = false
