# ============================================================================
# Example: Basic Trial Subaccount Configuration
# ============================================================================
# This example creates a minimal trial subaccount without additional services.
# Authentication must be configured via environment variables:
#   export BTP_USERNAME="your-email@example.com"
#   export BTP_PASSWORD="your-password"
#
# Usage:
#   terraform init
#   terraform plan -var-file="terraform.trial.tfvars"
#   terraform apply -var-file="terraform.trial.tfvars"
# ============================================================================

# BTP Global Account (REQUIRED - find this in BTP Cockpit)
globalaccount = "my-trial-account-subdomain"

# Subaccount Configuration
name        = "My Trial Subaccount"
subdomain   = "mycompany-trial"
region      = "us10" # Trial-friendly region (alternatives: eu10, ap21)
description = "Trial subaccount for testing BTP foundation module"

# Production Flag (trial = false)
is_production = false

# Optional: Contact Information
contact_persons = [
  # "developer@example.com"
]

# Optional: Custom Labels
additional_labels = {
  Environment = ["trial"]
  Purpose     = ["testing"]
}

# Optional Features (disabled by default for minimal setup)
enable_cloudfoundry     = false
enable_custom_ias_trust = false
enable_integrationsuite = false
