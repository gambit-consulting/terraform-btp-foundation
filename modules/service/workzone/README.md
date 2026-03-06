# BTP Workzone Service Module

This module creates entitlements and subscriptions for SAP Build Work Zone in BTP subaccounts, providing access to centralized launchpad, workspace, and collaboration capabilities.

## Usage

### Standard Edition

```hcl
module "workzone_standard" {
  source  = "gambit-consulting/foundation/btp//modules/service/workzone"
  version = "0.0.1"

  subaccount_id           = module.production_subaccount.id
  trust_configuration_id  = module.production_subaccount.custom_ias_trust_id

  service_name = "SAPLaunchpad"
  plan_name    = "standard"
}
```

### Advanced Edition

```hcl
module "workzone_advanced" {
  source  = "gambit-consulting/foundation/btp//modules/service/workzone"
  version = "0.0.1"

  subaccount_id           = module.production_subaccount.id
  trust_configuration_id  = module.production_subaccount.custom_ias_trust_id

  service_name = "SAPWorkZone"
  plan_name    = "advanced"
}
```

## Input Variables

| Name                   | Type   | Default        | Description                                                            |
| ---------------------- | ------ | -------------- | ---------------------------------------------------------------------- |
| subaccount_id          | string | required       | The ID of the BTP subaccount where Workzone should be deployed         |
| trust_configuration_id | string | required       | ID of the trust configuration (required for OpenID Connect dependency) |
| service_name           | string | "SAPLaunchpad" | Workzone service name (see valid combinations below)                   |
| app_name               | string | null           | Workzone app name (usually same as service_name)                       |
| plan_name              | string | "standard"     | Workzone plan (see valid combinations below)                           |

### Valid Service/Plan Combinations

| Service Name            | Valid Plans          | Edition                       |
| ----------------------- | -------------------- | ----------------------------- |
| SAPLaunchpad            | standard, foundation | SAP Build Work Zone, standard |
| SAPWorkZone             | advanced             | SAP Build Work Zone, advanced |
| build-workzone-standard | foundation           | SAP Build Work Zone, standard |
| build-workzone-advanced | advanced             | SAP Build Work Zone, advanced |

## Outputs

| Name               | Description                                           |
| ------------------ | ----------------------------------------------------- |
| entitlement_id     | ID of the Workzone entitlement                        |
| entitlement_state  | State of the entitlement (OK/PROCESSING/FAILED)       |
| subscription_id    | ID of the Workzone subscription                       |
| subscription_url   | URL to access Workzone launchpad                      |
| subscription_state | State of the subscription (SUBSCRIBED/NOT_SUBSCRIBED) |
| service_name       | The service name used                                 |
| plan_name          | The plan name used                                    |
| subaccount_id      | The subaccount ID where the service is deployed       |

## Important Notes

### Trust Configuration Requirement

- **OpenID Connect Required**: Workzone requires an OpenID Connect trust configuration with SAP Cloud Identity Services. SAML trust is not supported.
- The `trust_configuration_id` parameter ensures proper dependency ordering during provisioning.
- For more information, see [SAP Help: Establish Trust and Federation](https://help.sap.com/docs/btp/sap-business-technology-platform/establish-trust-and-federation-between-uaa-and-identity-authentication)

### Understanding service_name vs app_name

Workzone is a **multitenant application** that requires both entitlement and subscription:

- **`service_name`**: The catalog identifier used for entitlements (can have multiple variants)
  - Examples: `SAPLaunchpad`, `build-workzone-standard` (both refer to the same offering)
- **`app_name`**: The actual multitenant application identifier used for subscriptions
  - Examples: `SAPLaunchpad` (for standard edition), `SAPWorkZone` (for advanced edition)

**The module automatically maps service names to their correct application names:**

| service_name            | →   | app_name     |
| ----------------------- | --- | ------------ |
| SAPLaunchpad            | →   | SAPLaunchpad |
| build-workzone-standard | →   | SAPLaunchpad |
| SAPWorkZone             | →   | SAPWorkZone  |
| build-workzone-advanced | →   | SAPWorkZone  |

You can override this by explicitly setting `app_name` if needed.

### Commercial Models and Licensing

SAP Build Work Zone offers different commercial models and licensing options:

- **Standard Edition**: Included with SAP BTP Cloud Platform Enterprise Agreement (CPEA) or available as a subscription service
- **Advanced Edition**: Requires a separate subscription and includes additional collaboration and workspace features
- **Foundation Plan**: Limited feature set included with certain BTP accounts at no additional cost

**Important Considerations:**

- User licensing is based on the number of users accessing the service
- Different plans have different feature sets and capacity limits
- Metering is based on active users and consumed resources

For detailed information about commercial models, metering, and licensing, see:

- [SAP Help: Commercial Models and Metering](https://help.sap.com/docs/build-work-zone-standard-edition/sap-build-work-zone-standard-edition/commercial-models-and-metering)
- [SAP Discovery Center: Work Zone Pricing](https://discovery-center.cloud.sap/serviceCatalog/sap-build-work-zone-standard-edition)
- https://help.sap.com/docs/build-service/build-service-guide/service-plans-and-metering?locale=en-US

## License

Apache License 2.0
