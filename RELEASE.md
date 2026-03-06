# Release Guide

This guide explains how to contribute code and how maintainers release new versions of terraform-btp-foundation to the Terraform Registry.

## Quick Start

### For Developers

1. Create a feature branch: `git checkout -b feature/your-feature-name`
2. Make changes following [CONTRIBUTING.md](CONTRIBUTING.md) guidelines
3. Commit with conventional format (enforced by commitlint):
   ```bash
   git commit -m "feat(subaccount): Add new capability"
   ```
4. Push and create a Pull Request
5. Once approved and merged, your changes are released with the next version tag

### For Repo Owners (Release Process)

1. Review merged commits since last release
2. Determine version bump (MAJOR.MINOR.PATCH)
3. Update CHANGELOG.md with new version entry
4. Create and push git tag: `git tag -a v0.1.0 -m "Release version 0.1.0"`
5. Push tag to GitHub: `git push origin v0.1.0`
6. Create GitHub Release from the tag
7. HCP automatically indexes and publishes to Terraform Registry

---

## Developer Workflow

### Creating a Feature Branch

Always create a feature branch from `main` for your changes:

```bash
# Update main to latest
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/your-feature-name
```

**Branch naming conventions:**
- `feature/` - New features: `feature/add-custom-labels`
- `fix/` - Bug fixes: `fix/authentication-timeout`
- `docs/` - Documentation: `docs/update-readme`
- `refactor/` - Code improvements: `refactor/simplify-logic`

### Making Commits

This repository enforces [Conventional Commits](https://www.conventionalcommits.org/) via `commitlint` pre-commit hooks.

**Format:**
```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

**Required elements:**
- **type**: Kind of change (`feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`, `ci`, `build`, `revert`)
- **scope**: OPTIONAL area affected (`core`, `subaccount`, `service/integrationsuite`, `service/workzone`)
- **subject**: Brief description (max 72 chars, lowercase, no period)

**Examples:**
```bash
# New feature
git commit -m "feat(subaccount): Add support for custom labels"

# Bug fix
git commit -m "fix(core): Resolve provider authentication timeout"

# Documentation
git commit -m "docs: Update module installation steps"

# Refactoring
git commit -m "refactor(service/integrationsuite): Simplify provisioning logic"

# With detailed description
git commit -m "feat(subaccount): Add custom label support

Allows users to define custom labels for subaccounts
during creation. Labels are stored in the subaccount
metadata for organization and filtering.

Closes #123"
```

### Creating a Pull Request

After pushing your feature branch:

```bash
git push origin feature/your-feature-name
```

Then create a PR on GitHub with:
- **Title**: Same format as commit (e.g., "feat(subaccount): Add custom labels")
- **Description**: Explain what changed and why
- **Reference issues**: Link related issues (e.g., "Closes #123")

**Before PR is merged:**
- All validation must pass (tofu fmt, tofu validate)
- At least one maintainer review
- No merge conflicts
- Commits follow conventional format

### Merging the PR

Repo owners will merge using GitHub's **Squash and merge** or **Create a merge commit** option. The PR will be closed automatically.

---

## Version Bumping Rules

This project uses [Semantic Versioning](https://semver.org/) (MAJOR.MINOR.PATCH) with versions determined automatically from commit types since the last release.

### How Commits Map to Version Numbers

| Commit Type | Version Impact | Example | New Version |
|---|---|---|---|
| `feat` | Adds backward-compatible feature | `feat(subaccount): Add labels` | v0.0.1 → **v0.1.0** |
| `fix` | Backward-compatible bug fix | `fix(core): Fix timeout` | v0.1.0 → **v0.1.1** |
| `fix!` or `BREAKING CHANGE` | Breaking change to API | `fix!: Change variable type` | v0.1.0 → **v1.0.0** |
| `refactor`, `style`, `docs`, `chore` | No version bump | - | No new release |

### Determining the Next Version

Review commits since the last release tag:

```bash
# See commits since last tag
git log v0.0.1..HEAD --oneline

# or see all commits grouped by type
git log v0.0.1..HEAD --format="%h %s" | sort
```

**Decision tree:**
1. If ANY commit has `BREAKING CHANGE` footer or `!` suffix → **MAJOR bump** (X.0.0)
2. Else if ANY commit is `feat` → **MINOR bump** (0.X.0)
3. Else if ANY commit is `fix` → **PATCH bump** (0.0.X)
4. Else (only `docs`, `chore`, `refactor`, etc.) → **No release** (skip version bump)

### Examples

**Scenario: Last release is v0.0.1**

Commits since v0.0.1:
```
- feat(subaccount): Add label support
- fix(core): Fix validation
- docs: Update README
```
→ **Next version: v0.1.0** (first `feat` determines MINOR bump)

**Scenario: Last release is v0.1.0**

Commits since v0.1.0:
```
- feat!: Change variable naming convention (BREAKING CHANGE)
- refactor: Simplify module structure
```
→ **Next version: v1.0.0** (breaking change determines MAJOR bump)

**Scenario: Last release is v1.2.0**

Commits since v1.2.0:
```
- fix: Resolve timeout issue
- fix: Fix validation logic
- chore: Update dependencies
```
→ **Next version: v1.2.1** (only `fix` commits, no features, no breaking changes)

---

## Maintainer: How to Release

This section is for **repo owners** who create official releases.

### Step 1: Review Merged Commits

Ensure all changes you want to release are merged to `main`:

```bash
git checkout main
git pull origin main

# View commits since last release
git log v0.0.1..HEAD --oneline
```

### Step 2: Determine Next Version

Using the [Version Bumping Rules](#version-bumping-rules) above, decide the new version number.

**Example decision:**
- Last release: v0.0.1
- Commits include: `feat(...)` and `fix(...)`
- Decision: Next version is **v0.1.0** (MINOR bump from new feature)

### Step 3: Update CHANGELOG.md

Add a new section for the version being released. Follow [Keep a Changelog](https://keepachangelog.com/) format.

**Changelog structure:**
```markdown
# Changelog

## [Unreleased]
(Leave empty - filled at next release)

## [0.1.0] - YYYY-MM-DD

### Added
- Subaccount label support for organization
- Custom identity provider trust configuration

### Fixed
- Provider authentication timeout issue

### Changed
- Updated module documentation

[0.1.0]: https://github.com/gambit-consulting/terraform-btp-foundation/releases/tag/v0.1.0
[0.0.1]: https://github.com/gambit-consulting/terraform-btp-foundation/releases/tag/v0.0.1
```

**How to compile changelog entries:**

Extract commit messages since last release and group by type:

```bash
# Get all commits since last release
git log v0.0.1..HEAD --format="- %s"

# Filter and organize by type:
# feat(...) → Added section
# fix(...) → Fixed section
# refactor(...) → Changed section
```

**Categories in order:**
1. **Added** - New features (`feat` commits)
2. **Fixed** - Bug fixes (`fix` commits without breaking change)
3. **Changed** - Refactors, improvements (`refactor`, `perf` commits)
4. **Deprecated** - Features marked as deprecated (if applicable)
5. **Removed** - Features that were removed (if applicable)
6. **Security** - Security fixes (if applicable)

### Step 4: Create Annotated Git Tag

Create a git tag with the version and a message:

```bash
# Create annotated tag (recommended)
git tag -a v0.1.0 -m "Release version 0.1.0"

# Or with multi-line message
git tag -a v0.1.0 -m "Release version 0.1.0

See CHANGELOG.md for details"
```

**Why annotated tags?**
- Contains author, date, and message information
- More meaningful than lightweight tags
- GitHub can use as release notes

### Step 5: Push Tag to GitHub

```bash
# Push the specific tag
git push origin v0.1.0

# Or push all tags at once
git push origin --tags
```

HCP Terraform Registry automatically indexes GitHub releases and publishes your module.

### Step 6: Create GitHub Release (Optional but Recommended)

While the tag itself triggers publishing, creating a GitHub Release provides better documentation.

**Via GitHub UI:**

1. Go to your repository: https://github.com/gambit-consulting/terraform-btp-foundation
2. Click **"Releases"** in the right sidebar
3. Click **"Draft a new release"**
4. **Tag version:** Select or type `v0.1.0` (must match your git tag)
5. **Release title:** `Release v0.1.0` or `v0.1.0`
6. **Description:** Copy from CHANGELOG.md section for this version:
   ```
   ## Added
   - Subaccount label support
   - Custom provider configuration
   
   ## Fixed
   - Authentication timeout
   
   See CHANGELOG.md for full details.
   ```
7. **Prerelease:** Check only if this is an alpha/beta/rc release
8. Click **"Publish release"**

**Via GitHub CLI:**

```bash
# Create release from existing tag with changelog content
gh release create v0.1.0 --title "v0.1.0" --notes "## Added
- Subaccount label support

## Fixed
- Authentication timeout"
```

---

## Changelog Strategy

This project uses **Option B: Auto-generated from commits at release time**.

### What This Means

- **Developers** commit using Conventional Commits format (already enforced)
- **Maintainers** compile changelog entries from commit messages when releasing
- **CHANGELOG.md** is updated manually (not auto-generated by tools) but uses commit history as the source

### Why This Approach?

✅ **Single source of truth** - Git commits are the canonical record
✅ **No duplicate work** - No changelog entries + code changes needed
✅ **Fewer merge conflicts** - Developers don't edit CHANGELOG.md
✅ **Consistent format** - All entries follow conventional commit types
✅ **Aligns with Git Flow** - Uses commits to determine what changed

### The Process

1. **During development:** Only commit messages matter
   - Conventional format is enforced by commitlint
   - No CHANGELOG.md changes needed

2. **At release time:** Maintainer reviews commits and creates changelog entry
   - Extract commits between last tag and HEAD
   - Group by type (Added/Fixed/Changed/etc.)
   - Write CHANGELOG.md entry
   - Commit the CHANGELOG.md update

3. **After release:** Tag is created with CHANGELOG.md entry

---

## Example Release Scenarios

### Scenario 1: Releasing v0.1.0 (First Minor Release)

**Situation:** Last release was v0.0.1 (initial release). New commits include two features and a bug fix.

**Step 1: Review commits**
```bash
git log v0.0.1..HEAD --oneline
```
Output:
```
abc1234 feat(subaccount): Add label support
def5678 fix(core): Resolve timeout
ghi9012 docs: Update README examples
```

**Step 2: Determine version**
- Has `feat` commits → MINOR bump
- Next version: **v0.1.0**

**Step 3: Update CHANGELOG.md**
```markdown
# Changelog

## [Unreleased]

## [0.1.0] - 2026-03-06

### Added
- Subaccount label support for organization and filtering
- Module documentation with usage examples

### Fixed
- Provider authentication timeout issue

[0.1.0]: https://github.com/gambit-consulting/terraform-btp-foundation/releases/tag/v0.1.0
[0.0.1]: https://github.com/gambit-consulting/terraform-btp-foundation/releases/tag/v0.0.1
```

**Step 4-5: Create tag and push**
```bash
# Commit CHANGELOG update first
git add CHANGELOG.md
git commit -m "chore: Release version 0.1.0"

# Create annotated tag
git tag -a v0.1.0 -m "Release version 0.1.0"

# Push both commit and tag
git push origin main
git push origin v0.1.0
```

**Step 6: Create GitHub Release**
- Go to Releases → Draft new release
- Select tag `v0.1.0`
- Title: `v0.1.0`
- Copy Added/Fixed sections from CHANGELOG.md
- Publish

✅ **HCP Terraform Registry auto-publishes the module**

---

### Scenario 2: Releasing v1.0.0 (Major/Stable Release)

**Situation:** Module is now mature enough for v1.0.0. Commits include a breaking change.

**Step 1: Review commits**
```bash
git log v0.1.0..HEAD --oneline
```
Output:
```
jkl3456 feat!: Rename variable convention (BREAKING CHANGE)
mno7890 refactor(service/integrationsuite): Simplify logic
pqr0123 feat(subaccount): Add encryption support
```

**Step 2: Determine version**
- Has `feat!` (breaking change) → MAJOR bump
- Next version: **v1.0.0**

**Step 3: Update CHANGELOG.md**
```markdown
## [1.0.0] - 2026-03-10

### Added
- Subaccount encryption support
- Enhanced module documentation

### Changed
- **BREAKING:** Renamed `custom_labels` to `metadata_labels` for consistency
  - Migration guide: rename `custom_labels` blocks to `metadata_labels`
- Simplified Integration Suite provisioning logic

### Migration Guide

Version 1.0.0 includes a breaking change:

```hcl
# Before (v0.x)
custom_labels = {
  environment = "production"
}

# After (v1.0.0)
metadata_labels = {
  environment = "production"
}
```

[1.0.0]: https://github.com/gambit-consulting/terraform-btp-foundation/releases/tag/v1.0.0
[0.1.0]: https://github.com/gambit-consulting/terraform-btp-foundation/releases/tag/v0.1.0
```

**Step 4-5: Create tag and push**
```bash
git add CHANGELOG.md
git commit -m "chore: Release version 1.0.0

This is the first major release, marking API stability."
git tag -a v1.0.0 -m "Release version 1.0.0 - First stable release"
git push origin main
git push origin v1.0.0
```

✅ **v1.0.0 published to Terraform Registry**

---

### Scenario 3: Releasing v1.0.1 (Hotfix/Patch Release)

**Situation:** Critical bug found in v1.0.0 in production. Quick fix needed.

**Step 1: Create hotfix branch**
```bash
git checkout -b fix/critical-bug v1.0.0

# Make fix and commit
git commit -m "fix: Resolve critical provider error"
```

**Step 2: Merge to main**
```bash
git push origin fix/critical-bug
# Create PR, get review, merge to main
```

**Step 3: Create release**
```bash
git checkout main
git pull origin main

# Review commits since last release
git log v1.0.0..HEAD --oneline
# Output: fix: Resolve critical provider error
```

**Step 4: Determine version**
- Only `fix` commits → PATCH bump
- Next version: **v1.0.1**

**Step 5: Update CHANGELOG.md**
```markdown
## [1.0.1] - 2026-03-12

### Fixed
- Critical provider error in subaccount provisioning

[1.0.1]: https://github.com/gambit-consulting/terraform-btp-foundation/releases/tag/v1.0.1
[1.0.0]: https://github.com/gambit-consulting/terraform-btp-foundation/releases/tag/v1.0.0
```

**Step 6-7: Release**
```bash
git add CHANGELOG.md
git commit -m "chore: Release version 1.0.1"
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin main
git push origin v1.0.1
```

✅ **Hotfix published**

---

## FAQ

### Q: What if I merged commits that don't need a release?

**A:** If all commits since last release are `docs`, `chore`, `refactor` etc. (no `feat` or `fix`), you can **skip the release**. Update CHANGELOG.md with a note in `[Unreleased]` if desired, but no tag is needed.

### Q: What if I accidentally made a breaking change in a `fix` commit?

**A:** You should have used `fix!: <subject>` with `BREAKING CHANGE` footer. If missed:
1. Create a new `docs` or `chore` commit
2. Make it clear in commit message this was unintended
3. Release as MAJOR version anyway
4. Document clearly in CHANGELOG.md and GitHub Release

### Q: How do I know when to do a major release vs minor?

**A:** Follow the rules in [Version Bumping Rules](#version-bumping-rules):
- **MAJOR (X.0.0):** Breaking changes to module API/variables
- **MINOR (0.X.0):** New backward-compatible features/modules
- **PATCH (0.0.X):** Bug fixes only

For a Terraform module, "breaking" means:
- Variable names changed
- Variable types changed (e.g., string → map)
- Required variable became optional (or vice versa)
- Output structure changed
- Module removed or renamed

### Q: Can multiple developers release?

**A:** Only **repo owners** should create releases and tags. Repo owners are defined in CODEOWNERS. For this project, releases are maintainer responsibility.

### Q: What if I need to release a prerelease version (alpha, beta, rc)?

**A:** Use prerelease format:
```bash
git tag -a v1.0.0-rc.1 -m "Release candidate 1 for v1.0.0"
git push origin v1.0.0-rc.1
```

Then on GitHub UI, mark the release as "Prerelease" before publishing.

### Q: What if I want to rename a tag?

**A:** Delete and recreate (only if not yet published to registry):
```bash
git tag -d v0.1.0           # Delete local tag
git push origin :v0.1.0     # Delete remote tag
git tag -a v0.1.0 -m "..."  # Recreate
git push origin v0.1.0
```

### Q: Where can I find my release after tagging?

**A:**
1. **GitHub:** https://github.com/gambit-consulting/terraform-btp-foundation/releases
2. **Terraform Registry:** https://registry.terraform.io/modules/gambit-consulting/terraform-btp-foundation (auto-indexed)
3. **Git tags:** `git tag -l` to list locally, or `git tag -l --sort=-version:refname` to sort by version

---

## Summary

| Role | Responsibility |
|---|---|
| **Developers** | Create feature branches, commit with conventional format, create PRs |
| **Repo Owners** | Review commits, update CHANGELOG.md, create and push tags, publish releases |
| **HCP Registry** | Auto-indexes git tags and publishes module versions |

**Key Points:**
- Commit message format is enforced (commitlint)
- Version bumps determined by commit types
- Changelog compiled from commits at release time
- One tag per release triggers automatic registry publication
- GitHub Releases provide user-friendly release notes
