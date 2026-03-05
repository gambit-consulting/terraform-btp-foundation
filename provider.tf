# Configure the BTP Provider
# Authentication is handled via environment variables:
# - BTP_USERNAME and BTP_PASSWORD (username/password auth)
# - BTP_ASSERTION (JWT Bearer assertion auth)
# - BTP_IDTOKEN (SAP-internal use only)
# For custom IdP, also set BTP_IDP environment variable
provider "btp" {
  globalaccount = var.globalaccount
}
