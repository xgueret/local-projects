# 🚀 Local Projects

![Stars](https://img.shields.io/github/stars/xgueret/local-projects?style=social) ![Last Commit](https://img.shields.io/github/last-commit/xgueret/local-projects)![Status](https://img.shields.io/badge/Status-Active-brightgreen) ![License](https://img.shields.io/badge/License-MIT-blue)
![Terraform](https://img.shields.io/badge/Terraform-%E2%89%A51.11.0-623CE4) ![Ansible](https://img.shields.io/badge/Ansible-2.14+-EE0000)

🛠️ Un environnement de développement local automatisé pour déployer diverses applications avec Ansible et Docker.

## 📋 Aperçu

Ce projet fournit une configuration automatisée pour un environnement de développement local avec plusieurs applications utiles via des playbooks Ansible. L'infrastructure est conteneurisée avec Docker et peut être facilement déployée sur n'importe quel système ayant les dépendances requises.

## 📱 Applications

Les applications suivantes sont incluses :

- **🏠 Homer** - Un dashboard pour organiser et accéder à tous vos services web
- **🎨 Excalidraw** - Un tableau blanc collaboratif virtuel
- **🗄️ PostgreSQL** - Un serveur de base de données partagé
- **📊 Planka** - Un système de gestion de projet open-source (style Kanban)
- **🤖 Ollama** - Infrastructure pour exécuter des modèles de langage locaux
- **🌐 Open WebUI** - Une interface utilisateur pour interagir avec les modèles Ollama

## ✅ Prérequis

- Python 3.x
- Ansible
- Docker et Docker Compose
- Git
- [Installing the NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

## 📥 Installation

1. Cloner le dépôt :

```bash
git clone https://github.com/xgueret/local-projects.git
cd local-projects
```

2. Installer les dépendances :

```bash
pip install -r requirements.txt
```

3. Installer les collections Ansible :

```bash
ansible-galaxy collection install -r collections.yml
```

4. Configurer les hooks pre-commit :

```bash
pre-commit install
```

## ⚙️ Configuration

Le projet utilise Ansible Vault pour stocker les informations sensibles. Créez un fichier de mot de passe :

```bash
echo "your-vault-password" > ~/Workspace/.vault/.vault_password
```

Modifiez les variables selon vos besoins :

    group_vars/all/main.yml - Configuration générale

    group_vars/all/vault/ - Contient les informations sensibles chiffrées

## 🚀 Déploiement

Déployer toutes les applications :

```bash
ansible-playbook deploy.yml
```

Déployer des applications spécifiques avec des tags :

```bash
ansible-playbook deploy.yml --tags "homer,postgres"
```

Tags disponibles :

* homer
* excalidraw
* postgres
* planka
* ollama
* open_webui

## 🔗 Accès aux applications

Après déploiement, les applications seront disponibles sur :

* 🏠 Homer: http://localhost:8081
* 🎨 Excalidraw: http://localhost:8082
* 🤖 Open WebUI: http://localhost:8080
* 🗄️ PostgreSQL: localhost:5432
* 🤖 Ollama API: http://localhost:11434

## 📁 Structure du projet

```bash
├── ansible.cfg                 # Configuration Ansible
├── collections.yml             # Collections Ansible requises
├── deploy.yml                  # Playbook principal
├── group_vars/                 # Variables pour tous les hôtes
│   └── all/
│       ├── main.yml            # Variables générales
│       └── vault/              # Variables sensibles chiffrées
├── inventory.yml               # Inventaire Ansible
├── requirements.txt            # Dépendances Python
└── roles/                      # Rôles spécifiques aux applications
    ├── common/                 # Tâches communes
    ├── excalidraw/
    ├── homer/
    ├── ollama/
    ├── open_webui/
    ├── planka/
    └── postgres/
```

## ☁️ Infrastructure as Code

Le projet inclut des configurations Terraform pour gérer les dépôts GitHub :

1. Aller dans le dossier GitHub :

```bash
cd github
```

2. Initialiser Terraform :

```bash
terraform init
```

3. Déployer l'infrastructure :

```bash
terraform apply
```

## 👨‍💻 Développement

Le projet inclut plusieurs outils pour la qualité du code :

- **🔍 Hooks pre-commit** - Appliquer les standards de qualité
- **🧪 Ansible Lint** - Vérifier les bonnes pratiques Ansible
- **📝 YAML Lint** - Valider le format des fichiers YAML
- **🛡️ ShellCheck** - Vérifier les scripts shell
- **🔧 Validateurs Terraform** - Valider les configurations Terraform

## 👥 Contributeurs

- **Auteur**: Xavier GUERET
  [![GitHub followers](https://img.shields.io/github/followers/xgueret?style=social)](https://github.com/xgueret)[![Twitter Follow](https://img.shields.io/twitter/follow/xgueret?style=social)](https://x.com/hixmaster)[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat&logo=linkedin)](https://www.linkedin.com/in/xavier-gueret-47bb3019b/)

## 🤝 Contribuer

**Les contributions sont bienvenues ! N'hésitez pas à soumettre une **[Pull Request](https://github.com/xgueret/local-projects/pulls).
