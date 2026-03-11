# Release Guide

Simple guide for contributing code and releasing new versions to the Terraform Registry.

## For Developers

See [CONTRIBUTING.md](CONTRIBUTING.md).

### 1. Create Feature Branch & Make Changes

```bash
git checkout -b feature/your-feature-name
```

### 2. Commit Using Conventional Commits

Commits must follow [Conventional Commits](https://www.conventionalcommits.org/) format:

```bash
git commit -m "feat(subaccount): Add custom labels"
git commit -m "fix(core): Resolve timeout issue"
git commit -m "docs: Update README"
```

### 3. Push & Create Pull Request

```bash
git push origin feature/your-feature-name
```

On GitHub:

- **Title**: Use conventional commit format (e.g., `feat(subaccount): Add custom labels`)
- **Description**: Explain what changed and why
- **Link issues**: Use `Closes #123` if applicable

### 4. Mark PR as Ready

Once your PR is ready for review:

- Ensure all validation passes (terraform fmt, validate)
- Request review from maintainers
- Address any feedback

Once approved, maintainers will merge and your changes will be included in the next release.

---

## For Maintainers (Repo Owners Only)

This project uses [Semantic Versioning](https://semver.org/) determined by [Conventional Commits](https://www.conventionalcommits.org/).

### Version Bumping Quick Reference

| Commit Type                  | Bump  | Example         |
| ---------------------------- | ----- | --------------- |
| `feat`                       | MINOR | v0.0.1 → v0.1.0 |
| `fix`                        | PATCH | v0.1.0 → v0.1.1 |
| `feat!` or `BREAKING CHANGE` | MAJOR | v0.1.0 → v1.0.0 |
| `docs`, `chore`, `refactor`  | None  | No release      |

### Release Process

**Step 1: Review commits since last release**

```bash
git checkout main
git pull origin main
git log v0.0.1..HEAD --oneline
```

**Step 2: Determine next version**

- Breaking change (`!` or `BREAKING CHANGE`)? → MAJOR bump
- New feature (`feat`)? → MINOR bump
- Bug fix (`fix`)? → PATCH bump
- Only `docs`/`chore`? → Skip release

**Step 3: Update CHANGELOG.md**

Add entry following [Keep a Changelog](https://keepachangelog.com/) format:

```markdown
## [0.1.0] - 2026-03-06

### Added

- Feature from feat(...) commits

### Fixed

- Bug fixes from fix(...) commits

[0.1.0]: https://github.com/gambit-consulting/terraform-btp-foundation/releases/tag/v0.1.0
```

Compile from commits:

```bash
git log v0.0.1..HEAD --format="- %s"
```

**Step 4: Commit, tag, and push**

```bash
# Commit changelog
git add CHANGELOG.md
git commit -m "chore(core): Release version 0.1.0"

# Create annotated tag
git tag -a v0.1.0 -m "Release version 0.1.0"

# Push both
git push origin main
git push origin v0.1.0
```

**Step 5: Create GitHub Release**

Via GitHub UI:

1. Go to: https://github.com/gambit-consulting/terraform-btp-foundation/releases
2. Click "Draft a new release"
3. Select tag: `v0.1.0`
4. Title: `v0.1.0`
5. Description: Copy from CHANGELOG.md
6. Click "Publish release"

Via CLI:

```bash
gh release create v0.1.0 --title "v0.1.0" --notes "$(cat changelog_excerpt.md)"
```

HCP Terraform Registry automatically indexes the tag and publishes the module.

### Merging Pull Requests

Review PR, ensure:

- Commits follow conventional format
- All checks pass
- Changes are documented

Merge using:

- **Squash and merge** (for multiple commits) → Creates single commit
- **Create a merge commit** (for clean history) → Preserves all commits

PR closes automatically after merge.

---

## Summary

**Developers:**

1. Create feature branch
2. Commit with conventional format
3. Create PR with conventional title
4. Mark ready when validation passes
5. Maintainers merge → changes included in next release

**Maintainers:**

1. Review commits since last release
2. Determine version bump from commit types
3. Update CHANGELOG.md from commit messages
4. Commit, tag, push
5. Create GitHub Release
6. HCP auto-publishes to Terraform Registry

**Key Resources:**

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [Keep a Changelog](https://keepachangelog.com/)
- [Contributing Guidelines](CONTRIBUTING.md)
