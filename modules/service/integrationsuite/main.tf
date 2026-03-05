resource "btp_subaccount_entitlement" "this" {
  subaccount_id = var.subaccount_id
  service_name  = var.service_name
  plan_name     = var.plan_name
  amount        = var.quota_amount
}

resource "btp_subaccount_subscription" "this" {
  subaccount_id = var.subaccount_id
  app_name      = var.app_name != null ? var.app_name : var.service_name
  plan_name     = var.plan_name
  depends_on    = [btp_subaccount_entitlement.this]
}