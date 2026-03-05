# Changelog

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2026-03-05

### Added

- Initial release of terraform-btp Monorepo
- `subaccount` module for creating and managing BTP subaccounts
  - Support for Cloud Foundry environment provisioning
  - Custom IAS identity provider trust configuration
  - Flexible labeling and contact person management
  - Production/non-production designation
- GitHub Actions workflow for Terraform validation and linting
- Contributing guidelines

### Technical Details

- Terraform >= 1.5.0
- SAP BTP Provider ~> 1.20.0
  [0.0.1]: https://github.com/gambit-consulting/terraform-btp/releases/tag/v0.0.1
