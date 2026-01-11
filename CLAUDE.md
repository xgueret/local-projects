# CLAUDE.md

Ce fichier fournit le contexte necessaire pour travailler sur ce projet.

## Description

**local-projects** est une solution d'Infrastructure as Code pour deployer un environnement de developpement local. Le projet utilise Ansible pour orchestrer des conteneurs Docker.

## Stack technique

- **Ansible** : Orchestration et configuration
- **Docker** : Conteneurisation des applications
- **Terraform** : Gestion du repo GitHub (dossier `github/`)
- **Python** : Runtime Ansible (venv inclus)
- **Ansible Vault** : Chiffrement des secrets

## Structure du projet

```
local-projects/
├── deploy.yml              # Playbook principal de deploiement
├── uninstall.yml           # Playbook de desinstallation
├── inventory.yml           # Inventaire (localhost)
├── ansible.cfg             # Configuration Ansible
├── group_vars/all/
│   ├── main.yml            # Variables globales
│   └── vault/              # Secrets chiffres (Ansible Vault)
├── roles/
│   ├── common/             # Taches partagees
│   ├── excalidraw/         # Application Excalidraw
│   └── open_webui/         # Interface Open WebUI
├── docs/                   # Documentation
├── github/                 # Terraform pour GitHub
└── .claude/commands/       # Commandes Claude
```

## Commandes importantes

```bash
# Deploiement
ansible-playbook deploy.yml                    # Deployer tout
ansible-playbook deploy.yml --tags "open_webui" # Deployer un role specifique

# Desinstallation
ansible-playbook uninstall.yml --tags "ollama"  # Desinstaller un role

# Validation
ansible-playbook deploy.yml --syntax-check      # Verifier syntaxe
ansible-playbook deploy.yml --check --diff      # Dry run

# Qualite
pre-commit run --all-files                      # Lancer tous les linters

# Vault
ansible-vault encrypt group_vars/all/vault/file.yml
ansible-vault decrypt group_vars/all/vault/file.yml
ansible-vault edit group_vars/all/vault/file.yml
```

## Conventions

### Structure d'un role

```
roles/<role_name>/
├── tasks/
│   ├── main.yml            # Deploiement
│   └── uninstall.yml       # Desinstallation
├── vars/
│   └── main.yml            # Variables du role
├── templates/              # Templates Jinja2
├── handlers/               # Handlers (optionnel)
└── defaults/               # Valeurs par defaut (optionnel)
```

### Nommage des variables

- Prefixer par le nom du role : `open_webui_port`, `excalidraw_version`
- Secrets dans `group_vars/all/vault/` uniquement
- Pas de valeurs sensibles en clair dans le code

### Types de commit

```
feat(role): nouvelle fonctionnalite
fix(role): correction de bug
infra: changement d'infrastructure
config: modification de configuration
docs: documentation
chore: maintenance
security: correctif de securite
```

## Ce qu'on FAIT

- Utiliser les FQCN (Fully Qualified Collection Names) : `ansible.builtin.file`
- Chiffrer tous les secrets avec Ansible Vault
- Creer un `uninstall.yml` pour chaque role
- Documenter les variables dans `vars/main.yml`
- Utiliser des handlers pour les redemarrages
- Tester avec `--check --diff` avant d'appliquer

## Ce qu'on NE FAIT PAS

- Commiter des fichiers vault non chiffres
- Utiliser `command`/`shell` quand un module Ansible existe
- Hardcoder des valeurs sensibles
- Deployer sans avoir teste en mode check
- Modifier directement les conteneurs (tout passe par Ansible)

## Applications disponibles

| Application | Port | Description |
|-------------|------|-------------|
| Open WebUI | 8080 | Interface web pour LLM |
| Excalidraw | 8082 | Tableau blanc collaboratif |

## Fichiers de configuration

- `ansible.cfg` : Configuration Ansible (vault, inventory, etc.)
- `.pre-commit-config.yaml` : Hooks de qualite (ansible-lint, yamllint, shellcheck)
- `.yamllint` : Configuration yamllint
- `.ansible-lint` : Configuration ansible-lint

## Vault

Le mot de passe vault est stocke dans : `~/Workspace/.vault/.vault_password`

Pour verifier qu'un fichier est chiffre :
```bash
head -1 group_vars/all/vault/file.yml
# Doit afficher : $ANSIBLE_VAULT;1.1;AES256
```
