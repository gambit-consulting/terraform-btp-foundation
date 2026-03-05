# Contributing to terraform-btp

Thank you for your interest in contributing! We welcome bug reports, feature requests, and pull requests.

## How to Contribute

### Reporting Issues

- Check existing issues to avoid duplicates
- Provide clear description and reproduction steps
- Include your OpenTofu version and BTP provider version

### Submitting Changes

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes to the Terraform files
4. Validate your changes locally (see below)
5. Commit with clear message: `git commit -m "Add: description of changes"`
6. Push and create a Pull Request

### Code Standards

- **OpenTofu Format:** Use `tofu fmt` for consistent formatting
  - 2-space indentation (standard for HCL)
  - Run `tofu fmt -recursive .` before committing
- **Variable Names:** Use snake_case, descriptive names
- **Documentation:** All variables and outputs must have descriptions
- **Comments:** Add comments for complex logic or non-obvious decisions
- **Security:** Never commit `.tfvars`, `.env`, or other sensitive files
  - These files are in `.gitignore` for protection

### Local Validation

Before pushing your changes, validate them locally:

**Format Code:**

```bash
# Format all Terraform files
tofu fmt -recursive .
```

**Validate Syntax:**

```bash
# Validate root configuration
tofu validate

# Validate each module
cd modules/subaccount && tofu validate
cd ../..
```

**Check for Errors:**

```bash
# Initialize (creates .terraform/ directory)
tofu init

# Plan to catch any issues
tofu plan
```

### Pull Request Process

1. Before submitting:
   - Run `tofu fmt -recursive .`
   - Run `tofu validate` in each module directory
   - Update `README.md` if variables/outputs changed
   - Update `CHANGELOG.md` with your changes
2. PR requirements:
   - Clear description of what changed and why
   - Reference any related issues
   - No merge conflicts
   - All validation passes
3. Review process:
   - Maintainers will review your changes
   - Changes may be requested before approval
   - Once approved, your PR will be merged

### Module Structure

Each module should follow this structure:

```txt
modules/module-name/
├── main.tf # Resource definitions
├── variables.tf # Input variables
├── outputs.tf # Output values
├── versions.tf # Provider and Terraform version requirements
└── README.md # Module documentation
```

### Commit Message Format

Use clear, descriptive commit messages:
Add: Brief description of what was added
Or:
Fix: Brief description of what was fixed
Or:
Update: Brief description of what was updated

### Questions or Need Help?

- Open an [issue](https://github.com/gambit-consulting/terraform-btp/issues) on GitHub
- Check existing issues for similar questions
- Be patient - this is community-driven and maintained in spare time

### License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.

We appreciate your contributions! 🚀
