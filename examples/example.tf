terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.38.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.38.0"
    }
  }
}

module "cloud_build" {
  source                = "./.."
  project_id            = "your-project-id"
  project_number        = "your-project-number"
  service_account_email = "your-project-number-compute@developer.gserviceaccount.com"
  github_connection = {
    name                       = "github-connection-name"
    app_installation_id        = "your-app-installation-id"
    oauth_token_secret_version = "projects/your-project-number/secrets/github-secret/versions/1"
  }
  repositories = [
    {
      name       = "repository-name"
      remote_uri = "https://github.com/your-org/repository.git"
    }
  ]
  triggers = [
    {
      name          = "trigger-name-1"
      tag_pattern   = "tag-pattern-1"
      filename      = "path/to/cloudbuild.yaml"
      repository_id = "repository-name"
    },
    {
      name          = "trigger-name-2"
      tag_pattern   = "tag-pattern-2"
      filename      = "path/to/cloudbuild.yaml"
      repository_id = "repository-name"
    },
    {
      name          = "trigger-name-3"
      tag_pattern   = "tag-pattern-3"
      filename      = "path/to/cloudbuild.yaml"
      repository_id = "repository-name"
    }
  ]
}
