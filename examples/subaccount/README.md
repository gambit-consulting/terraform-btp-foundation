# Subaccount Module Example

This example demonstrates how to use the BTP subaccount module to create and configure a BTP subaccount.

## Prerequisites

- Terraform >= 1.0
- SAP BTP Terraform Provider configured with appropriate credentials
- A valid BTP global account ID

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

## Example with Cloud Foundry

To enable Cloud Foundry environment, update `terraform.tfvars`:

```hcl
enable_cloudfoundry = true
cf_plan_name       = "standard"
```

## Example with Custom IAS Trust

To configure custom Identity Authentication Service:

```hcl
enable_custom_ias_trust = true
ias_tenant_host         = "mytenant.authentication.sap.hana.ondemand.com"
```

## Outputs

After applying the configuration, you can access:

- `subaccount_id` - The unique identifier of the subaccount
- `subaccount_subdomain` - The subdomain assigned to the subaccount
- `subaccount_name` - The display name of the subaccount
- `custom_ias_origin` - The origin of the IAS trust configuration (if enabled)
- `cloudfoundry_landscape` - The CF landscape information (if enabled)

## Module Variables

Refer to the [module documentation](../../modules/subaccount/README.md) for detailed information about all available variables and their descriptions.

## Cleanup

To destroy the resources created by this example:

```bash
terraform destroy
```
