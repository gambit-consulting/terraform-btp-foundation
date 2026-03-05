variable "globalaccount" {
  description = "The BTP global account identifier"
  type        = string
}

variable "subaccount_name" {
  description = "Display name of the subaccount"
  type        = string
  default     = "My Development Subaccount"
}

variable "subaccount_description" {
  description = "Description of the subaccount"
  type        = string
  default     = "Example subaccount for Terraform BTP module"
}

variable "subdomain" {
  description = "Subdomain for the subaccount"
  type        = string
  default     = "my-company-dev"
}

variable "region" {
  description = "BTP region for the subaccount"
  type        = string
  default     = "us10"
}

variable "parent_directory_id" {
  description = "ID of the parent BTP directory"
  type        = string
  default     = null
}

variable "is_production" {
  description = "Whether this subaccount is used for production workloads"
  type        = bool
  default     = false
}

variable "status" {
  description = "Status label for the subaccount"
  type        = string
  default     = "active"
}

variable "contact_persons" {
  description = "List of contact person email addresses"
  type        = list(string)
  default     = []
}

variable "additional_labels" {
  description = "Additional custom labels for the subaccount"
  type        = map(list(string))
  default = {
    Environment = ["development"]
    CostCenter  = ["12345"]
  }
}

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

variable "enable_cloudfoundry" {
  description = "Enable Cloud Foundry environment"
  type        = bool
  default     = false
}

variable "cf_plan_name" {
  description = "Cloud Foundry plan name"
  type        = string
  default     = "standard"
}
