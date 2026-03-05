# ============================================================================
# Example: Trial Subaccount with Cloud Foundry Environment
# ============================================================================
# This example creates a trial subaccount with Cloud Foundry runtime enabled.
# Cloud Foundry provides a PaaS environment for deploying applications.
#
# Authentication must be configured via environment variables:
#   export BTP_USERNAME="your-email@example.com"
#   export BTP_PASSWORD="your-password"
#
# Usage:
#   terraform init
#   terraform plan -var-file="terraform.trial-with-cf.tfvars"
#   terraform apply -var-file="terraform.trial-with-cf.tfvars"
# ============================================================================

# BTP Global Account (REQUIRED - find this in BTP Cockpit)
globalaccount = "my-trial-account-subdomain"

# Subaccount Configuration
name        = "My Trial Subaccount with Cloud Foundry"
subdomain   = "mycompany-trial-cf"
region      = "us10" # CF-supported trial region (alternatives: eu10, ap21)
description = "Trial subaccount with Cloud Foundry for app development"

# Production Flag (trial = false)
is_production = false

# Optional: Contact Information
contact_persons = [
  # "developer@example.com"
]

# Optional: Custom Labels
additional_labels = {
  Environment = ["trial"]
  Purpose     = ["development"]
  Runtime     = ["cloudfoundry"]
}

# Cloud Foundry Configuration (ENABLED)
enable_cloudfoundry = true
cf_plan_name        = "trial" # Use trial plan for free tier

# Optional Features (disabled)
enable_custom_ias_trust = false
enable_integrationsuite = false
