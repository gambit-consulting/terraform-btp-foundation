module "subaccount" {
  source = "./modules/subaccount"

  # Basic Configuration
  name                = var.name
  description         = var.description
  subdomain           = var.subdomain
  region              = var.region
  parent_directory_id = var.parent_directory_id

  # Metadata & Labels
  is_production     = var.is_production
  status            = var.status
  contact_persons   = var.contact_persons
  additional_labels = var.additional_labels

  # IAS Trust Configuration
  enable_custom_ias_trust = var.enable_custom_ias_trust
  ias_tenant_host         = var.ias_tenant_host

  # Cloud Foundry Configuration
  enable_cloudfoundry = var.enable_cloudfoundry
  cf_plan_name        = var.cf_plan_name
}

module "integrationsuite" {
  count  = var.enable_integrationsuite ? 1 : 0
  source = "./modules/service/integrationsuite"

  subaccount_id = module.subaccount.id
  service_name  = var.integrationsuite_service_name
  app_name      = var.integrationsuite_app_name
  plan_name     = var.integrationsuite_plan_name
  quota_amount  = var.integrationsuite_quota_amount
}
