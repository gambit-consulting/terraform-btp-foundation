locals {
  valid_combinations = {
    "integrationsuite"       = ["basic_edition", "standard_edition", "premium_edition"]
    "integrationsuite-trial" = ["trial"]
  }
}

variable "subaccount_id" {
  description = "The ID of the BTP subaccount where Integration Suite should be deployed"
  type        = string
}

variable "service_name" {
  description = "Integration Suite service name"
  type        = string
  default     = "integrationsuite"
  validation {
    condition     = contains(keys(local.valid_combinations), var.service_name)
    error_message = "Service name must be one of: ${join(", ", keys(local.valid_combinations))}"
  }
}

variable "app_name" {
  description = "Integration Suite app name (usually same as service_name)"
  type        = string
  default     = null
}

variable "plan_name" {
  description = "Integration Suite plan"
  type        = string
  default     = "standard_edition"
  validation {
    condition     = contains(lookup(local.valid_combinations, var.service_name, []), var.plan_name)
    error_message = "Plan '${var.plan_name}' is not valid for service '${var.service_name}'. Valid plans are: ${join(", ", lookup(local.valid_combinations, var.service_name, []))}"
  }
}

variable "quota_amount" {
  description = "Quota amount for the entitlement"
  type        = number
  default     = 1

  validation {
    condition     = var.quota_amount >= 1
    error_message = "Quota amount must be at least 1"
  }
}
