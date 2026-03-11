# terraform-btp-foundation

Community-driven Terraform modules for SAP Business Technology Platform (BTP). Built for production use, no warranty.

## Repository Structure

```
terraform-btp-foundation/
├── modules/
│   ├── subaccount/          # Subaccount management
│   └── service/             # BTP service modules
│       ├── integrationsuite/
│       └── workzone/
├── examples/                # Usage examples
└── *.tf                     # Root module
```

## Available Modules

- **subaccount** - Manage BTP subaccounts
- **service/integrationsuite** - Integration Suite provisioning
- **service/workzone** - Work Zone provisioning

## Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines and [RELEASE.md](RELEASE.md) for release process.

## License

Apache License 2.0 - See [LICENSE](LICENSE) file for details.
