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
  version = "0.0.1"

  name        = var.subaccount_name
  subdomain   = var.subdomain
  region      = var.region
  description = "Subaccount for Integration Suite example"
}

module "integration_suite" {
  source  = "gambit-consulting/foundation/btp//modules/srv-integrationsuite"
  version = "0.0.1"

  subaccount_id = module.subaccount.id
  service_name  = var.service_name
  plan_name     = var.plan_name
  quota_amount  = var.quota_amount
}
