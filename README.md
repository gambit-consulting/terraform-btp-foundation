# terraform-btp-foundation

Community-driven Terraform modules for SAP Business Technology Platform (BTP). Built for production use, no warranty.

## Repository Structure

```
terraform-btp-foundation/
├── modules/
│   ├── subaccount/             # Subaccount management
│   ├── srv-integrationsuite/   # Integration Suite service module
│   └── srv-workzone/           # Work Zone service module
├── examples/                   # Usage examples
└── *.tf                        # Root module
```

## Available Modules

- **subaccount** - Manage BTP subaccounts
- **srv-integrationsuite** - Integration Suite provisioning
- **srv-workzone** - Work Zone provisioning

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines and [RELEASE.md](RELEASE.md) for release process.

## License

Apache License 2.0 - See [LICENSE](LICENSE) file for details.
