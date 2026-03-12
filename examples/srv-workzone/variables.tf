variable "globalaccount" {
  description = "The BTP global account identifier"
  type        = string
}

variable "subaccount_name" {
  description = "Display name of the subaccount"
  type        = string
  default     = "Work Zone Example"
}

variable "subdomain" {
  description = "Subdomain for the subaccount"
  type        = string
  default     = "my-company-workzone"
}

variable "region" {
  description = "BTP region for the subaccount"
  type        = string
  default     = "us10"
}

variable "enable_custom_ias_trust" {
  description = "Enable custom IAS trust configuration (required for Work Zone)"
  type        = bool
  default     = true
}

variable "ias_tenant_host" {
  description = "IAS tenant host for custom trust configuration (e.g., my-tenant.accounts.ondemand.com)"
  type        = string
  default     = ""
}

variable "service_name" {
  description = "Work Zone service name"
  type        = string
  default     = "SAPLaunchpad"
  validation {
    condition     = contains(["SAPLaunchpad", "SAPWorkZone", "build-workzone-standard", "build-workzone-advanced"], var.service_name)
    error_message = "Service name must be one of: SAPLaunchpad, SAPWorkZone, build-workzone-standard, build-workzone-advanced"
  }
}

variable "plan_name" {
  description = "Work Zone plan"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["standard", "foundation", "advanced"], var.plan_name)
    error_message = "Plan name must be one of: standard, foundation, advanced"
  }
}
