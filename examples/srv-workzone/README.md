# SAP Build Work Zone Service Module Example

This example demonstrates how to use the BTP Work Zone service module to provision SAP Build Work Zone in a BTP subaccount.

## Prerequisites

- Terraform >= 1.5.0
- SAP BTP Terraform Provider configured with appropriate credentials
- A valid BTP global account ID
- Sufficient entitlements for Work Zone in your global account
- An SAP Cloud Identity Services (IAS) tenant with custom trust configuration

## Important Note

SAP Build Work Zone requires an OpenID Connect trust configuration with SAP Cloud Identity Services. This example automatically configures the required trust configuration using the subaccount module's `enable_custom_ias_trust` parameter.

## Usage

### 1. Configure Variables

Edit `terraform.tfvars` with your BTP environment details:

```hcl
globalaccount       = "your-global-account-id"
subdomain           = "your-desired-subdomain"
region              = "us10"  # or your preferred region
ias_tenant_host     = "your-tenant.accounts.ondemand.com"
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Plan and Apply

```bash
terraform plan
terraform apply
```

## Example with Standard Edition (SAP Launchpad)

Default configuration uses SAP Launchpad with standard plan:

```hcl
service_name = "SAPLaunchpad"
plan_name    = "standard"
```

## Example with Foundation Plan

To use SAP Launchpad with foundation plan:

```hcl
service_name = "SAPLaunchpad"
plan_name    = "foundation"
```

## Example with Advanced Edition (SAP Work Zone)

To use the advanced edition with full Work Zone capabilities:

```hcl
service_name = "SAPWorkZone"
plan_name    = "advanced"
```

## Example with Build Work Zone Standard

To use the Build Work Zone Standard (new naming):

```hcl
service_name = "build-workzone-standard"
plan_name    = "foundation"
```

## Example with Build Work Zone Advanced

To use the Build Work Zone Advanced (new naming):

```hcl
service_name = "build-workzone-advanced"
plan_name    = "advanced"
```

## Available Service and Plan Combinations

| Service Name              | Valid Plans             | Description                                    |
|---------------------------|-------------------------|------------------------------------------------|
| `SAPLaunchpad`            | standard, foundation    | SAP Launchpad service (standard edition)       |
| `SAPWorkZone`             | advanced                | SAP Work Zone (advanced edition)               |
| `build-workzone-standard` | foundation              | Build Work Zone Standard (new naming)          |
| `build-workzone-advanced` | advanced                | Build Work Zone Advanced (new naming)          |

## Outputs

After applying the configuration, you can access:

- `subaccount_id` - The unique identifier of the subaccount
- `subaccount_subdomain` - The subdomain assigned to the subaccount
- `entitlement_id` - ID of the Work Zone entitlement
- `entitlement_state` - State of the entitlement (OK/PROCESSING/FAILED)
- `subscription_id` - ID of the Work Zone subscription
- `subscription_url` - URL to access Work Zone
- `subscription_state` - State of the subscription (SUBSCRIBED/NOT_SUBSCRIBED)
- `service_name` - The service name used
- `plan_name` - The plan name used

## Module Variables

Refer to the [module documentation](../../modules/srv-workzone/README.md) for detailed information about all available variables and their descriptions.

## Cleanup

To destroy the resources created by this example:

```bash
terraform destroy
```

**Note:** Ensure you have backed up any configurations or data in your Work Zone instance before destroying the resources.
