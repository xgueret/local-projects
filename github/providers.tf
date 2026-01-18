terraform {
  required_version = ">= 1.11.0"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.10"
    }
  }
}

provider "github" {
  token = var.github_token
}
