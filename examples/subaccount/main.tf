terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "~> 1.0"
    }
  }
}

provider "btp" {
  globalaccount = var.globalaccount
}

module "subaccount" {
  source = "../../modules/subaccount"

  name                    = var.subaccount_name
  description             = var.subaccount_description
  subdomain               = var.subdomain
  region                  = var.region
  parent_directory_id     = var.parent_directory_id
  is_production           = var.is_production
  status                  = var.status
  contact_persons         = var.contact_persons
  additional_labels       = var.additional_labels
  enable_custom_ias_trust = var.enable_custom_ias_trust
  ias_tenant_host         = var.ias_tenant_host
  enable_cloudfoundry     = var.enable_cloudfoundry
  cf_plan_name            = var.cf_plan_name
}
