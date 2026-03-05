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
  description = "ID of the parent BTP directory"
  type        = string
  default     = null
}

variable "subdomain" {
  description = "Subdomain for the subaccount (<company>(-<directory>)-<purpose>)"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.subdomain))
    error_message = "Subdomain must contain only lowercase letters, numbers, and hyphens"
  }
}

variable "region" {
  description = "BTP region for the subaccount"
  type        = string
}

variable "is_production" {
  description = "Whether this subaccount is used for production workloads"
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

# IAS Trust Configuration
variable "enable_custom_ias_trust" {
  description = "Enable custom IAS trust configuration"
  type        = bool
  default     = false
}
variable "ias_tenant_host" {
  description = "IAS tenant host for custom trust configuration"
  type        = string
  default     = null
}

# Cloud Foundry Configuration
variable "enable_cloudfoundry" {
  description = "Enable Cloud Foundry environment"
  type        = bool
  default     = false
}

variable "cf_plan_name" {
  description = "Cloud Foundry plan name (trial/standard)"
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["trial", "standard"], var.cf_plan_name)
    error_message = "CF plan must be either 'trial' or 'standard'"
  }
}
