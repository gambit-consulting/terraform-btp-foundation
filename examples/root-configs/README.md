# Root Configuration Examples

This directory contains example `.tfvars` files demonstrating different configurations for the BTP Foundation module.

## Prerequisites

Before using these examples, ensure you have:

1. **Terraform** installed (version >= 1.5.0)
2. **SAP BTP Account** with appropriate permissions
3. **Authentication credentials** configured via environment variables

## Authentication Setup

The module supports multiple authentication methods. Choose one:

### Option 1: Username/Password (Default IdP)

```bash
export BTP_USERNAME="your-email@example.com"
export BTP_PASSWORD="your-password"
```

### Option 2: Username/Password (Custom IdP)

```bash
export BTP_USERNAME="your-email@example.com"
export BTP_PASSWORD="your-password"
export BTP_IDP="customerTenant.accounts.ondemand.com"
```

### Option 3: JWT Bearer Assertion

```bash
export BTP_ASSERTION="your-jwt-token"
export BTP_IDP="customerTenant.accounts.ondemand.com"
```

### Option 4: X.509 Certificate

```bash
export BTP_USERNAME="technical-user@example.com"
export BTP_IDP="customerTenant.accounts.ondemand.com"
# Certificate and key configured in Terraform
```

## Available Examples

### 1. Basic Trial (`terraform.trial.tfvars`)

**Description**: Minimal trial subaccount without additional services.

**Use Case**: Quick setup for testing or learning BTP basics.

**What's Included**:
- BTP subaccount (trial/non-production)
- Basic labels and metadata
- No additional services

**Usage**:
```bash
cd ../..  # Navigate to repository root
terraform init
terraform plan -var-file="examples/root-configs/terraform.trial.tfvars"
terraform apply -var-file="examples/root-configs/terraform.trial.tfvars"
```

---

### 2. Trial with Cloud Foundry (`terraform.trial-with-cf.tfvars`)

**Description**: Trial subaccount with Cloud Foundry runtime environment.

**Use Case**: Application development using Cloud Foundry PaaS.

**What's Included**:
- BTP subaccount (trial/non-production)
- Cloud Foundry environment (trial plan)
- PaaS capabilities for app deployment

**Usage**:
```bash
cd ../..  # Navigate to repository root
terraform init
terraform plan -var-file="examples/root-configs/terraform.trial-with-cf.tfvars"
terraform apply -var-file="examples/root-configs/terraform.trial-with-cf.tfvars"
```

**Post-Deployment**:
After deployment, you can access Cloud Foundry:
```bash
# Get CF API endpoint from outputs
terraform output cloudfoundry_landscape_label

# Log in to CF
cf login
```

---

### 3. Trial with Integration Suite (`terraform.integrationsuite-trial.tfvars`)

**Description**: Trial subaccount with SAP Integration Suite subscription.

**Use Case**: Integration development and testing (CPI, API Management, etc.).

**What's Included**:
- BTP subaccount (trial/non-production)
- Integration Suite subscription (trial plan)
- Access to Cloud Integration, API Management, Open Connectors

**Usage**:
```bash
cd ../..  # Navigate to repository root
terraform init
terraform plan -var-file="examples/root-configs/terraform.integrationsuite-trial.tfvars"
terraform apply -var-file="examples/root-configs/terraform.integrationsuite-trial.tfvars"
```

**Post-Deployment**:
Access Integration Suite:
```bash
# Get subscription URL from outputs
terraform output integrationsuite_subscription_url
```

---

## Customizing Examples

To customize these examples:

1. **Copy the example file**:
   ```bash
   cp examples/root-configs/terraform.trial.tfvars terraform.tfvars
   ```

2. **Edit with your values**:
   - Update `globalaccount` with your BTP global account subdomain
   - Change `subdomain` to something unique
   - Adjust `region` to your preferred location
   - Add your contact information

3. **Apply the configuration**:
   ```bash
   terraform plan
   terraform apply
   ```

   Note: When using `terraform.tfvars`, you don't need the `-var-file` flag.

## Important Notes

### Trial Account Limitations

- **Trial plans** have resource limitations and are not suitable for production
- Some services may have reduced quotas in trial mode
- Trial accounts may have expiration dates

### Regions

Common trial-friendly regions:
- `us10` - US East (VA) - AWS
- `eu10` - Europe (Frankfurt) - AWS
- `ap21` - Singapore - AWS

Check [SAP Discovery Center](https://discovery-center.cloud.sap/) for current region availability.

### Subdomain Naming

Subdomains must:
- Be globally unique within the region
- Contain only lowercase letters, numbers, and hyphens
- Not start or end with a hyphen

Format recommendation: `<company>-<purpose>` (e.g., `acme-trial`, `acme-dev`)

## Cleanup

To remove all resources:

```bash
terraform destroy -var-file="examples/root-configs/terraform.trial.tfvars"
```

**Warning**: This will delete the subaccount and all associated resources!

## Troubleshooting

### "Subdomain already exists"

Error: The subdomain is already in use. Change the `subdomain` variable to a unique value.

### "Missing Username/Password"

Ensure authentication environment variables are set correctly:
```bash
echo $BTP_USERNAME
echo $BTP_PASSWORD
```

### "Entitlement not available"

Some services require entitlements to be assigned to your global account first. Check the BTP Cockpit.

## Further Resources

- [SAP BTP Documentation](https://help.sap.com/docs/btp)
- [Terraform BTP Provider](https://registry.terraform.io/providers/SAP/btp/latest/docs)
- [Module Documentation](../../README.md)
