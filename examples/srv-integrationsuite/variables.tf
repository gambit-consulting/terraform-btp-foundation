variable "globalaccount" {
  description = "The BTP global account identifier"
  type        = string
}

variable "subaccount_name" {
  description = "Display name of the subaccount"
  type        = string
  default     = "Integration Suite Example"
}

variable "subdomain" {
  description = "Subdomain for the subaccount"
  type        = string
  default     = "my-company-integration"
}

variable "region" {
  description = "BTP region for the subaccount"
  type        = string
  default     = "us10"
}

variable "service_name" {
  description = "Integration Suite service name"
  type        = string
  default     = "integrationsuite"
  validation {
    condition     = contains(["integrationsuite", "integrationsuite-trial"], var.service_name)
    error_message = "Service name must be either 'integrationsuite' or 'integrationsuite-trial'"
  }
}

variable "plan_name" {
  description = "Integration Suite plan"
  type        = string
  default     = "standard_edition"
}

variable "quota_amount" {
  description = "Quota amount for the entitlement"
  type        = number
  default     = 1
}

variable "app_name" {
  description = "Integration Suite app name (usually same as service_name)"
  type        = string
  default     = null
}
