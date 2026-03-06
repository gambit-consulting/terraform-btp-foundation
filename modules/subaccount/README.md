# BTP Subaccount Module

This module creates and manages SAP BTP subaccounts with optional Cloud Foundry environments and custom identity provider configurations.

## Usage

```hcl
module "development_subaccount" {
  source  = "gambit-consulting/foundation/btp//modules/subaccount"
  version = "0.0.1"

  name                    = "Development"
  subdomain               = "org-sales-eu-dev"
  region                  = "eu10"

  description             = "Subaccount for development stage"
  parent_directory_id     = "Sales"
  ias_tenant_host         = "<tenant>.accounts.ondemand.com"
}
```

## Input Variables

| Name                    | Type              | Default    | Description                                            |
| ----------------------- | ----------------- | ---------- | ------------------------------------------------------ |
| name                    | string            | required   | Display name of the subaccount                         |
| subdomain               | string            | required   | Subdomain for the subaccount (lowercase, hyphens only) |
| region                  | string            | required   | BTP region (e.g., eu10, us10, ap10)                    |
| description             | string            | null       | Description of the subaccount                          |
| parent_directory_id     | string            | null       | ID of the parent BTP directory                         |
| ias_tenant_host         | string            | null       | IAS tenant host for custom trust config                |
| is_production           | bool              | false      | Whether subaccount is used for production              |
| status                  | string            | "active"   | Status label: active or inactive                       |
| contact_persons         | list(string)      | []         | Contact person email addresses                         |
| additional_labels       | map(list(string)) | {}         | Custom labels for the subaccount                       |
| enable_custom_ias_trust | bool              | false      | Enable custom IAS trust configuration                  |
| enable_cloudfoundry     | bool              | false      | Enable Cloud Foundry environment                       |
| cf_plan_name            | string            | "standard" | Cloud Foundry plan: trial or standard                  |

## Outputs

| Name                         | Description                                                 |
| ---------------------------- | ----------------------------------------------------------- |
| id                           | The ID of the BTP subaccount                                |
| subdomain                    | The subdomain of the BTP subaccount                         |
| name                         | The name of the BTP subaccount                              |
| custom_ias_trust_origin      | Origin of the custom IAS trust configuration (if enabled)   |
| cloudfoundry_labels          | Labels from Cloud Foundry environment (if enabled)          |
| cloudfoundry_landscape_label | Landscape label from Cloud Foundry environment (if enabled) |

## License

Apache License 2.0
