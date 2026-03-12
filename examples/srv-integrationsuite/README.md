# Integration Suite Service Module Example

This example demonstrates how to use the BTP Integration Suite service module to provision SAP Integration Suite in a BTP subaccount.

## Prerequisites

- Terraform >= 0.20.0
- SAP BTP Terraform Provider configured with appropriate credentials
- A valid BTP global account ID
- Sufficient entitlements for Integration Suite in your global account

## Usage

### 1. Configure Variables

Edit `terraform.tfvars` with your BTP environment details:

```hcl
globalaccount = "your-global-account-id"
subdomain     = "your-desired-subdomain"
region        = "us10"  # or your preferred region
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

## Example with Trial Plan

To use Integration Suite trial edition, update `terraform.tfvars`:

```hcl
service_name = "integrationsuite-trial"
plan_name    = "trial"
```

## Example with Premium Edition

To use Integration Suite premium edition:

```hcl
service_name = "integrationsuite"
plan_name    = "premium_edition"
quota_amount = 1
```

## Available Plans

### For `integrationsuite` service:
- `basic_edition` - Basic Integration Suite capabilities
- `standard_edition` - Standard Integration Suite (default)
- `premium_edition` - Premium Integration Suite with advanced features

### For `integrationsuite-trial` service:
- `trial` - Trial version of Integration Suite

## Outputs

After applying the configuration, you can access:

- `subaccount_id` - The unique identifier of the subaccount
- `subaccount_subdomain` - The subdomain assigned to the subaccount
- `entitlement_id` - ID of the Integration Suite entitlement
- `entitlement_state` - State of the entitlement (OK/PROCESSING/FAILED)
- `subscription_id` - ID of the Integration Suite subscription
- `subscription_url` - URL to access Integration Suite (CPI, API Management, etc.)
- `subscription_state` - State of the subscription (SUBSCRIBED/NOT_SUBSCRIBED)
- `service_name` - The service name used
- `plan_name` - The plan name used

## Module Variables

Refer to the [module documentation](../../modules/srv-integrationsuite/README.md) for detailed information about all available variables and their descriptions.

## Cleanup

To destroy the resources created by this example:

```bash
terraform destroy
```

**Note:** Ensure you have backed up any configurations or data in your Integration Suite instance before destroying the resources.
