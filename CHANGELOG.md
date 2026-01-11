# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- UV support for Python dependency management
- `scripts/ansible-vault-pass.sh` for secure vault password retrieval via `pass`
- Open source documentation (CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md)
- GitHub issue and PR templates
- CI workflow for automated linting

### Changed

- Migrated from `requirements.txt` to `pyproject.toml` with UV
- Updated `.envrc` for UV virtual environment management

### Removed

- Deprecated roles (homer, ollama, planka, postgres)
- Orphan configuration files for removed roles

## [0.1.0] - Initial Release

### Added

- Excalidraw deployment role
- Open WebUI deployment role
- Common role for shared configurations
- Ansible Vault integration for secrets
- Pre-commit hooks (ansible-lint, yamllint, shellcheck, terraform)
- Terraform configuration for GitHub repository management
