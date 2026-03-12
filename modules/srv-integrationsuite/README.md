# BTP Integration Suite Service Module

This module creates entitlements and subscriptions for SAP Integration Suite in BTP subaccounts, providing access to integration capabilities including CPI, API Management, and other integration tools.

## Usage

```hcl
module "integration_suite_development" {
  source  = "gambit-consulting/foundation/btp//modules/service/integrationsuite"
  version = "0.0.1"

  subaccount_id = module.development_subaccount.id

  service_name = "integrationsuite"
  plan_name    = "standard_edition"
  quota_amount = 1
}
```

## Input Variables

| Name          | Type   | Default            | Description                                                                         |
| ------------- | ------ | ------------------ | ----------------------------------------------------------------------------------- |
| subaccount_id | string | required           | The ID of the BTP subaccount where Integration Suite should be deployed             |
| service_name  | string | "integrationsuite" | Integration Suite service name (integrationsuite or integrationsuite-trial)         |
| app_name      | string | null               | Integration Suite app name (usually same as service_name)                           |
| plan_name     | string | "standard_edition" | Integration Suite plan (basic_edition, standard_edition, premium_edition, or trial) |
| quota_amount  | number | 1                  | Quota amount for the entitlement (must be at least 1)                               |

## Outputs

| Name               | Description                                                 |
| ------------------ | ----------------------------------------------------------- |
| entitlement_id     | ID of the Integration Suite entitlement                     |
| entitlement_state  | State of the entitlement (OK/PROCESSING/FAILED)             |
| subscription_id    | ID of the Integration Suite subscription                    |
| subscription_url   | URL to access Integration Suite (CPI, API Management, etc.) |
| subscription_state | State of the subscription (SUBSCRIBED/NOT_SUBSCRIBED)       |
| service_name       | The service name used                                       |
| plan_name          | The plan name used                                          |

## License

Apache License 2.0
