variable "project_id" {
  description = "The project ID to deploy resources into"
  type        = string
}

variable "project_number" {
  description = "The number of the GCP project"
  type        = string
}

variable "service_account_email" {
  description = "The main service account email"
  type        = string
}

variable "region" {
  description = "The region in which to create the repositories"
  type        = string
  default     = "europe-west1"
}

variable "github_connection" {
  description = "The GitHub connection details"
  type = object({
    name                       = string
    app_installation_id        = number
    oauth_token_secret_version = string
  })
}

variable "repositories" {
  description = "List of GitHub repositories to connect"
  type = list(object({
    name       = string
    remote_uri = string
  }))
  default = []
}

variable "triggers" {
  description = "List of Cloud Build trigger configurations"
  type = list(object({
    name          = string
    repository_id = string
    tag_pattern   = string
    filename      = string
  }))
  default = []
}

