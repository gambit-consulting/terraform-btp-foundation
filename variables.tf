# ============================================================================
# BTP Provider Configuration
# ============================================================================

variable "globalaccount" {
  description = "The subdomain of the BTP global account (find this in the cockpit)"
  type        = string
}

# ============================================================================
# Subaccount Configuration
# ============================================================================

variable "name" {
  description = "Display name of the subaccount"
  type        = string
}

variable "description" {
  description = "Description of the subaccount"
  type        = string
  default     = null
}

variable "parent_directory_id" {
  description = "ID of the parent BTP directory (if null, created directly in global account)"
  type        = string
  default     = null
}

variable "subdomain" {
  description = "Subdomain for the subaccount (use format: <company>-<purpose>, e.g., 'mycompany-trial')"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.subdomain))
    error_message = "Subdomain must contain only lowercase letters, numbers, and hyphens"
  }
}

variable "region" {
  description = "BTP region for the subaccount (e.g., 'us10', 'eu10', 'ap21')"
  type        = string
}

variable "is_production" {
  description = "Whether this subaccount is used for production workloads (affects billing and support)"
  type        = bool
  default     = false
}

variable "status" {
  description = "Status label for the subaccount (active/inactive)"
  type        = string
  default     = "active"

  validation {
    condition     = contains(["active", "inactive"], var.status)
    error_message = "Status must be either 'active' or 'inactive'"
  }
}

variable "contact_persons" {
  description = "List of contact person email addresses"
  type        = list(string)
  default     = []
}

variable "additional_labels" {
  description = "Additional custom labels for the subaccount"
  type        = map(list(string))
  default     = {}
}

# ============================================================================
# IAS Trust Configuration (Optional)
# ============================================================================

variable "enable_custom_ias_trust" {
  description = "Enable custom IAS (Identity Authentication Service) trust configuration"
  type        = bool
  default     = false
}

variable "ias_tenant_host" {
  description = "IAS tenant host for custom trust configuration (required if enable_custom_ias_trust is true)"
  type        = string
  default     = null
}

# ============================================================================
# Cloud Foundry Configuration (Optional)
# ============================================================================

variable "enable_cloudfoundry" {
  description = "Enable Cloud Foundry environment instance"
  type        = bool
  default     = false
}

variable "cf_plan_name" {
  description = "Cloud Foundry plan name (trial/standard)"
  type        = string
  default     = "trial"

  validation {
    condition     = contains(["trial", "standard"], var.cf_plan_name)
    error_message = "CF plan must be either 'trial' or 'standard'"
  }
}

# ============================================================================
# Integration Suite Service Configuration (Optional)
# ============================================================================

variable "enable_integrationsuite" {
  description = "Enable SAP Integration Suite subscription"
  type        = bool
  default     = false
}

variable "integrationsuite_service_name" {
  description = "Integration Suite service name (integrationsuite or integrationsuite-trial)"
  type        = string
  default     = "integrationsuite-trial"

  validation {
    condition     = contains(["integrationsuite", "integrationsuite-trial"], var.integrationsuite_service_name)
    error_message = "Service name must be 'integrationsuite' or 'integrationsuite-trial'"
  }
}

variable "integrationsuite_plan_name" {
  description = "Integration Suite plan name (trial, basic_edition, standard_edition, premium_edition)"
  type        = string
  default     = "trial"

  validation {
    condition     = contains(["trial", "basic_edition", "standard_edition", "premium_edition"], var.integrationsuite_plan_name)
    error_message = "Plan must be one of: trial, basic_edition, standard_edition, premium_edition"
  }
}

variable "integrationsuite_app_name" {
  description = "Integration Suite app name (usually same as service_name, leave null for auto-detection)"
  type        = string
  default     = null
}

variable "integrationsuite_quota_amount" {
  description = "Quota amount for the Integration Suite entitlement"
  type        = number
  default     = 1

  validation {
    condition     = var.integrationsuite_quota_amount >= 1
    error_message = "Quota amount must be at least 1"
  }
}
