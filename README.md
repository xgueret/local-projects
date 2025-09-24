# 🚀 Local Projects

![Stars](https://img.shields.io/github/stars/xgueret/local-projects?style=social) ![Last Commit](https://img.shields.io/github/last-commit/xgueret/local-projects)![Status](https://img.shields.io/badge/Status-Active-brightgreen) ![License](https://img.shields.io/badge/License-MIT-blue)
![Terraform](https://img.shields.io/badge/Terraform-%E2%89%A51.11.0-623CE4) ![Ansible](https://img.shields.io/badge/Ansible-2.14+-EE0000)

Automated local development environment for deploying various applications with Ansible and Docker.

## 📋 Overview

This project provides automated configuration for a local development environment with multiple useful applications via Ansible playbooks. The infrastructure is containerized with Docker and can be easily deployed on any system with the required dependencies.

## 📱 Available Applications

The following applications can be deployed:

- **🏠 Homer** - A dashboard to organize and access all your web services
- **🎨 Excalidraw** - A virtual collaborative whiteboard
- **🗄️ PostgreSQL** - A shared database server
- **📊 Planka** - An open-source project management system (Kanban-style)
- **🤖 Ollama** - Infrastructure for running local language models
- **🌐 Open WebUI** - A web interface to interact with Ollama models

*Note: The configuration currently has `deploy_homer: true`, `deploy_excalidraw: true`, `deploy_open_webui: true`, `deploy_ollama: true`, and `deploy_planka: false` by default.*

## ✅ Prerequisites

- Python 3.x
- Ansible
- Docker and Docker Compose
- Git
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) (only required if using GPU acceleration with Ollama)

## 📥 Installation

1. Clone the repository:

```bash
git clone https://github.com/xgueret/local-projects.git
cd local-projects
```

2. Install Python dependencies:

```bash
pip install -r requirements.txt
```

3. Install Ansible collections:

```bash
ansible-galaxy collection install -r requirements.yml
```

4. Configure pre-commit hooks:

```bash
pre-commit install
```

## ⚙️ Configuration

The project uses Ansible Vault to store sensitive information. Create a password file:

```bash
# Create directory if it doesn't exist
mkdir -p ~/Workspace/.vault

# Create password file
echo "your-vault-password" > ~/Workspace/.vault/.vault_password
```

You can modify configuration variables as needed:

- `group_vars/all/main.yml` - General configuration
- `group_vars/all/postgres.yml` - PostgreSQL-specific configuration
- `group_vars/all/vault/` - Contains sensitive, encrypted information

## 🚀 Deployment

Deploy all enabled applications:

```bash
ansible-playbook deploy.yml
```

Deploy specific applications with tags:

```bash
ansible-playbook deploy.yml --tags "excalidraw,ollama,open_webui"
```

Available tags:

* `excalidraw`
* `ollama`
* `open_webui`
* `postgres` (currently commented out in the playbook)
* `homer` (currently commented out in the playbook)
* `planka` (currently disabled in main.yml)

## 🔗 Application Access

After deployment, the applications will be available at:

* 🎨 **Excalidraw**: http://localhost:8082
* 🤖 **Ollama UI**: http://localhost:8080
* 🤖 **Ollama API**: http://localhost:11434
* 🗄️ **PostgreSQL**: localhost:5432 (internal access only)

*Note: Homer is configured to run on port 8081 but is commented out in the playbook.*

## 📁 Project Structure

```
├── ansible.cfg                 # Ansible configuration
├── deploy.yml                  # Main playbook
├── group_vars/                 # Variables for all hosts
│   └── all/
│       ├── main.yml            # General variables (defines which apps to deploy)
│       ├── postgres.yml        # PostgreSQL specific variables
│       └── vault/              # Sensitive encrypted variables
├── inventory.yml               # Ansible inventory
├── requirements.txt            # Python dependencies
├── requirements.yml            # Ansible collection dependencies
├── roles/                      # Application-specific roles
│   ├── common/                 # Common tasks
│   ├── excalidraw/
│   ├── homer/
│   ├── ollama/
│   ├── open_webui/
│   ├── planka/
│   └── postgres/
├── github/                     # Terraform configuration for GitHub management
└── .vscode/                    # VSCode settings
```

## 🤖 Ollama Configuration

The Ollama integration includes:
- Automatic GPU support detection and configuration
- Automatic CLI extraction from container for local usage
- Profile script for easy CLI access via `ollama-local` command
- Health checks to ensure the API is ready

For GPU acceleration, ensure the NVIDIA Container Toolkit is installed and the `ollama_use_gpu` variable is set to `true` in your configuration.

## ☁️ GitHub Infrastructure as Code

The project includes Terraform configurations to manage GitHub repositories in the `github/` directory:

1. Change to the GitHub directory:

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

The project includes several tools for code quality:

- **🔍 Pre-commit hooks** - Apply quality standards
- **🧪 Ansible Lint** - Check Ansible best practices
- **📝 YAML Lint** - Validate YAML file formats
- **🛡️ ShellCheck** - Check shell scripts
- **🔧 Terraform validators** - Validate Terraform configurations

## 🚨 Troubleshooting

### Common Issues:

1. **Permission errors with Docker**:
   - Ensure your user is in the `docker` group: `sudo usermod -aG docker $USER`
   - Log out and back in for changes to take effect

2. **Vault password issues**:
   - Ensure the vault password file is at `~/Workspace/.vault/.vault_password`
   - Check that the password is correct

3. **GPU support for Ollama**:
   - Install NVIDIA Container Toolkit
   - Verify with `docker info | grep -i nvidia`
   - Set `ollama_use_gpu: true` in your configuration

4. **Port conflicts**:
   - Check if required ports are already in use: `sudo netstat -tulpn | grep :PORT`
   - Modify ports in `group_vars/all/*.yml` files as needed

## 👥 Author

- **Xavier GUERET**
  [![GitHub followers](https://img.shields.io/github/followers/xgueret?style=social)](https://github.com/xgueret)[![Twitter Follow](https://img.shields.io/twitter/follow/xgueret?style=social)](https://x.com/hixmaster)[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/xavier-gueret-47bb3019b/)

## 🤝 Contributing

**Contributions are welcome! Please feel free to submit a **[Pull Request](https://github.com/xgueret/local-projects/pulls).

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
