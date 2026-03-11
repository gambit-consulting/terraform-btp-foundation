# Agent Guidelines for terraform-btp-foundation

Technical reference for AI coding agents working in this Terraform modules repository.

## Repository Architecture

**Focus: Self-Contained Submodules**

- Primary focus is on developing reusable, self-contained modules in `modules/`
- Each submodule (subaccount, service/integrationsuite, service/workzone) is independently consumable
- Root configuration exists solely for testing, validation, and convenience
- When developing, prioritize module completeness and independence over root configuration

## Terraform MCP Server

When interacting with Terraform files, use the **terraform-mcp-server** for enhanced capabilities:

- **Documentation:** https://developer.hashicorp.com/terraform/mcp-server
- **Purpose:** Provides MCP (Model Context Protocol) interface for Terraform operations
- **Use cases:** Module documentation lookup, provider details, resource schema validation
- Prefer MCP server tools for Terraform-specific queries over manual file reading

## Build/Lint/Test Commands

### Quick Validation (Makefile)

```bash
# Format all Terraform files
make fmt

# Format + validate syntax
make validate

# Format + validate + plan
make plan

# Clean plan output
make clean
```

### Individual Commands

```bash
# Format (recursive)
terraform fmt -recursive .

# Format single file
terraform fmt path/to/file.tf

# Validate root module
terraform validate

# Validate specific module
cd modules/subaccount && terraform validate && cd ../..

# Initialize and plan
terraform init
terraform plan
```

### Pre-commit Hooks

Installed hooks (runs automatically on commit):

- `terraform_fmt` - Auto-formats all .tf files
- `terraform_validate` - Validates Terraform syntax
- `terraform_tflint` - Lints Terraform code
- `commitlint` - Enforces conventional commit format

Manual trigger:

```bash
pre-commit run --all-files
```

### Module-Specific Validation

```bash
# Validate each module independently
for module in modules/subaccount modules/service/integrationsuite modules/service/workzone; do
  cd $module && terraform init && terraform validate && cd -
done
```

## Code Style Guidelines

### Formatting

- **Indentation:** 2 spaces (HCL standard)
- **Line length:** No strict limit, use readability judgment
- **Trailing commas:** Not required in HCL
- **Blank lines:** Single blank line between resources

### Naming Conventions

- **Variables:** `snake_case`, descriptive (e.g., `parent_directory_id`, `enable_cloudfoundry`)
- **Resources:** Use `this` for primary resource, descriptive names for secondary (e.g., `btp_subaccount.this`, `btp_subaccount_trust_configuration.custom_ias`)
- **Outputs:** Match variable names where applicable, use `snake_case`
- **Modules:** `lowercase-hyphenated` directory names (e.g., `modules/subaccount`)
- **Files:** Standard names only: `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`, `provider.tf`

### Variables (REQUIRED Standards)

Every variable must include:

```hcl
variable "example_name" {
  description = "Clear description of purpose"  # REQUIRED
  type        = string                          # REQUIRED
  default     = null                            # Optional (omit if required)

  validation {                                  # REQUIRED for constrained values
    condition     = contains(["value1", "value2"], var.example_name)
    error_message = "Must be one of: value1, value2"
  }
}
```

**Validation patterns:**

- String format: `can(regex("^[a-z0-9-]+$", var.subdomain))`
- Enum values: `contains(["active", "inactive"], var.status)`
- Boolean conditions: Direct boolean checks

### Outputs (REQUIRED Standards)

Every output must include:

```hcl
output "example_output" {
  description = "Clear description of output value"  # REQUIRED
  value       = resource.type.this.attribute
  sensitive   = false  # Set true for secrets
}
```

### Comments

```hcl
# Single-line comments above code blocks
# Use for complex logic or non-obvious decisions
# Do NOT state the obvious

# Example: Good comment
# Cloud Foundry environment is optional and controlled by enable_cloudfoundry flag
resource "btp_subaccount_environment_instance" "cloudfoundry" {
  count = var.enable_cloudfoundry ? 1 : 0
  ...
}

# Example: Bad comment (obvious)
# This creates a subaccount
resource "btp_subaccount" "this" {
  ...
}
```

### Resource Patterns

- **Conditional resources:** Use `count = condition ? 1 : 0`
- **Dynamic blocks:** Use `for_each` for multiple similar items
- **Labels/Tags:** Use `merge()` for combining default and custom labels
- **Dependencies:** Use `depends_on` only when implicit dependencies insufficient

### Types

Standard HCL types:

- `string`, `number`, `bool`
- `list(string)`, `list(number)`
- `map(string)`, `map(list(string))`
- `object({...})` for complex structures

### Error Handling

- **Validation errors:** Write clear, actionable messages
- **Example:** `"Subdomain must contain only lowercase letters, numbers, and hyphens"`
- **Format:** Describe what IS allowed, not just what failed

## Module Structure

### Required Files (every module)

```
modules/module-name/
├── main.tf        # Resource definitions
├── variables.tf   # Input variables with descriptions
├── outputs.tf     # Output values with descriptions
├── versions.tf    # Terraform and provider version constraints
└── README.md      # Module documentation
```

### Version Requirements

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    btp = {
      source  = "SAP/btp"
      version = "~> 1.20.0"
    }
  }
}
```

### Module Documentation (README.md)

Must include:

- Brief description
- Usage example
- Input variables table
- Output values table

## Git Commit Conventions

### Format (Conventional Commits)

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

### Required Components

- **type:** One of: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert`
- **scope:** Optional, must be one of: `core`, `subaccount`, `service/integrationsuite`, `service/workzone`
- **subject:** Brief description (max 72 chars total header length)

### Examples

```
feat(subaccount): Add custom labels support
fix(core): Resolve provider authentication timeout
docs: Update README with repo structure
chore: Update dependencies
refactor(service/integrationsuite): Simplify provisioning logic
```

### Pre-commit Validation

Commitlint enforces format automatically. If commit fails:

1. Check message format matches pattern above
2. Verify scope is in allowed list
3. Ensure type is lowercase

## Quick Reference

**Before committing:**

```bash
make fmt validate
pre-commit run --all-files
```

**Module checklist:**

- [ ] All variables have descriptions, types, validation
- [ ] All outputs have descriptions
- [ ] README.md updated
- [ ] Follows module structure pattern
- [ ] Validated with `terraform validate`

**Key files:**

- `.commitlintrc.json` - Commit message rules
- `.pre-commit-config.yaml` - Pre-commit hook config
- `Makefile` - Build commands
- `CONTRIBUTING.md` - Full contributor guide
