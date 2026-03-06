# Configure your subaccount (for business users) to trust a tenant of SAP Cloud Identity Services using OpenID Connect. SAML trust isn't supported for this service.
# For more information, see <https://help.sap.com/docs/btp/sap-business-technology-platform/establish-trust-and-federation-between-uaa-and-identity-authentication>
# this is why there is a dependency to `var.trust_configuration_id`

locals {
  # Map service names to their corresponding application names
  # This handles cases where service_name and app_name differ (e.g., build-workzone-* variants)
  service_to_app_map = {
    "SAPLaunchpad"            = "SAPLaunchpad"
    "SAPWorkZone"             = "SAPWorkZone"
    "build-workzone-standard" = "SAPLaunchpad"
    "build-workzone-advanced" = "SAPWorkZone"
  }

  # Determine the effective app_name: explicit var.app_name > mapped value > fallback to service_name
  effective_app_name = coalesce(
    var.app_name,
    lookup(local.service_to_app_map, var.service_name, null),
    var.service_name
  )
}

resource "btp_subaccount_entitlement" "this" {
  subaccount_id = var.subaccount_id
  service_name  = var.service_name
  plan_name     = var.plan_name
}

resource "btp_subaccount_subscription" "this" {
  subaccount_id = var.subaccount_id
  app_name      = local.effective_app_name
  plan_name     = var.plan_name
  depends_on = [
    btp_subaccount_entitlement.this,
    var.trust_configuration_id
  ]
}
