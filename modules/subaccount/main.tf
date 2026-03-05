resource "btp_subaccount" "this" {
  name         = var.name
  description  = var.description
  parent_id    = var.parent_directory_id
  subdomain    = var.subdomain
  region       = var.region
  usage        = var.is_production ? "USED_FOR_PRODUCTION" : "NOT_USED_FOR_PRODUCTION"
  beta_enabled = var.is_production ? false : true

  labels = merge(
    {
      "Status"         = [var.status]
      "Contact Person" = var.contact_persons
    },
    var.additional_labels
  )
}

resource "btp_subaccount_trust_configuration" "custom_ias" {
  count             = var.enable_custom_ias_trust ? 1 : 0
  subaccount_id     = btp_subaccount.this.id
  identity_provider = var.ias_tenant_host
  name              = "Custom IAS Trust Configuration"
  description       = "Identity Authentication tenant ${var.ias_tenant_host} used for Business Users"
  #   origin                   = "sap.custom"
  available_for_user_logon = true
  auto_create_shadow_users = true
  #   status                   = "active"
  link_text = "Corporate Identity Provider (${var.ias_tenant_host})"
}

# REVISIT this should be in a second apply step as it has dependencies which cannto be planned by terraform
# import {
#   to         = btp_subaccount_trust_configuration.sap_default_dev
#   id         = "${btp_subaccount.kgm_am_development.id},sap.default"
# }

# resource "btp_subaccount_trust_configuration" "sap_default_dev" {
#   subaccount_id            = btp_subaccount.kgm_am_development.id
#   identity_provider        = ""
#   available_for_user_logon = false
#   auto_create_shadow_users = false
#   depends_on               = [btp_subaccount.kgm_am_development]
# }

# Optional: Cloud Foundry Environment
resource "btp_subaccount_environment_instance" "cloudfoundry" {
  count = var.enable_cloudfoundry ? 1 : 0

  subaccount_id    = btp_subaccount.this.id
  name             = btp_subaccount.this.subdomain
  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  plan_name        = var.cf_plan_name
  #   landscape_label  = var.cf_landscape_label

  parameters = jsonencode({
    instance_name = btp_subaccount.this.subdomain
  })
}
