terraform {
  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "~> 1.20.0"
    }
  }
}

provider "btp" {
  globalaccount = var.globalaccount
}

module "subaccount" {
  source  = "gambit-consulting/foundation/btp//modules/subaccount"
  version = "0.1.0"

  name                    = var.subaccount_name
  subdomain               = var.subdomain
  region                  = var.region
  description             = "Subaccount for SAP Build Work Zone example"
  enable_custom_ias_trust = var.enable_custom_ias_trust
  ias_tenant_host         = var.ias_tenant_host
}

module "workzone" {
  source  = "gambit-consulting/foundation/btp//modules/srv-workzone"
  version = "0.1.0"

  subaccount_id          = module.subaccount.id
  service_name           = var.service_name
  plan_name              = var.plan_name
  trust_configuration_id = module.subaccount.custom_ias_trust_origin
}
