# 🚀 Local Projects

![Stars](https://img.shields.io/github/stars/xgueret/local-projects?style=social) ![Last Commit](https://img.shields.io/github/last-commit/xgueret/local-projects)![Status](https://img.shields.io/badge/Status-Active-brightgreen) ![License](https://img.shields.io/badge/License-MIT-blue)
![Terraform](https://img.shields.io/badge/Terraform-%E2%89%A51.11.0-623CE4) ![Ansible](https://img.shields.io/badge/Ansible-2.14+-EE0000)


🛠️ A local development environment that automates the deployment of various applications using Ansible and Docker.

## 📋 Overview

This project provides an automated setup for a local development environment with several useful applications through Ansible playbooks. The infrastructure is containerized using Docker and can be easily deployed on any system with the required dependencies.

## 📱 Applications

The following applications are included:

- **🏠 Homer** - A dashboard to organize and access all your web services
- **🎨 Excalidraw** - A virtual collaborative whiteboard tool
- **🗄️ PostgreSQL** - A shared database server
- **📊 Planka** - An open-source project management system (Kanban-style)
- **🤖 Open WebUI** - A user interface for interacting with Ollama language models

## ✅ Prerequisites

- Python 3.x
- Ansible
- Docker and Docker Compose
- Git

## 📥 Installation

1. Clone the repository:

```bash
git clone https://github.com/xgueret/local-projects.git
cd local-projects
```

2. Install required dependencies:

```bash
pip install -r requirements.txt
```

3. Install Ansible collections:

```bash
ansible-galaxy collection install -r collections.yml
```

4. Set up pre-commit hooks:

```bash
pre-commit install
```

## ⚙️ Configuration

The project uses Ansible Vault for secure storage of sensitive information. You'll need to create a vault password file:

```bash
echo "your-vault-password" > ~/Workspace/.vault/.vault_password
```

Edit the group variables as needed:

- `group_vars/all/main.yml` - General configuration
- `group_vars/all/vault/` - Contains encrypted sensitive information

## 🚀 Deployment

Deploy all applications:

```bash
ansible-playbook deploy.yml
```

Deploy specific applications using tags:

```bash
ansible-playbook deploy.yml --tags "homer,postgres"
```

Available tags:
- `homer`
- `excalidraw`
- `postgres`
- `planka`
- `open_webui`

## 🔗 Application Access

After deployment, the applications will be available at:

- 🏠 Homer: http://localhost:8081
- 🎨 Excalidraw: http://localhost:8082
- 📊 Planka: http://localhost:8083
- 🤖 Open WebUI: http://localhost:8080

## 📁 Project Structure

```
├── ansible.cfg                 # Ansible configuration
├── collections.yml             # Required Ansible collections
├── deploy.yml                  # Main deployment playbook
├── group_vars/                 # Variables for all hosts
│   └── all/
│       ├── main.yml            # General variables
│       └── vault/              # Encrypted sensitive variables
├── inventory.yml               # Ansible inventory
├── requirements.txt            # Python dependencies
└── roles/                      # Application-specific roles
    ├── excalidraw/
    ├── homer/
    ├── open_webui/
    ├── planka/
    └── postgres/
```

## ☁️ Infrastructure as Code

The project includes Terraform configurations to manage GitHub repositories. To use this feature:

1. Navigate to the GitHub directory:

```bash
cd github
```

2. Initialize Terraform:

```bash
terraform init
```

3. Deploy the infrastructure:

```bash
terraform apply
```

## 👨‍💻 Development

The project includes several tools for development quality:

- **🔍 Pre-commit hooks** - Enforce code quality and standards
- **🧪 Ansible Lint** - Ensure Ansible playbooks follow best practices
- **📝 YAML Lint** - Validate YAML files for proper formatting
- **🛡️ ShellCheck** - Check shell scripts for common issues
- **🔧 Terraform validators** - Validate Terraform configurations

## 👥 Contributors

* **Author**: Xavier GUERET
  [![GitHub followers](https://img.shields.io/github/followers/xgueret?style=social)](https://github.com/xgueret)[![Twitter Follow](https://img.shields.io/twitter/follow/xgueret?style=social)](https://x.com/hixmaster)[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/xavier-gueret-47bb3019b/)

# 🤝 Contributing

**Contributions are welcome! Please feel free to submit a **[Pull Request](https://github.com/xgueret/local-projects/pulls).
