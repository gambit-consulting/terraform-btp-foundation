locals {
  valid_combinations = {
    "SAPLaunchpad"            = ["standard", "foundation"]
    "SAPWorkZone"             = ["advanced"]
    "build-workzone-standard" = ["foundation"]
    "build-workzone-advanced" = ["advanced"]
  }
}

variable "subaccount_id" {
  description = "The ID of the BTP subaccount where Workzone should be deployed"
  type        = string
}

variable "service_name" {
  description = "Workzone service name"
  type        = string
  default     = "SAPLaunchpad"
  validation {
    condition     = contains(keys(local.valid_combinations), var.service_name)
    error_message = "Service name must be one of: ${join(", ", keys(local.valid_combinations))}"
  }
}

variable "app_name" {
  description = "Workzone app name (usually same as service_name)"
  type        = string
  default     = null
}

variable "plan_name" {
  description = "Workzone plan"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(lookup(local.valid_combinations, var.service_name, []), var.plan_name)
    error_message = "Plan '${var.plan_name}' is not valid for service '${var.service_name}'. Valid plans are: ${join(", ", lookup(local.valid_combinations, var.service_name, []))}"
  }
}

variable "trust_configuration_id" {
  description = "ID of the trust configuration (required for OpenID Connect dependency)"
  type        = string
}