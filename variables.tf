variable "project" {
  description = "The project object containing the project ID and project number."
  type = object({
    project_id       = string
    project_services = map(object({}))
    service_accounts = optional(map(object({
      description    = optional(string)
      display_name   = optional(string)
      email          = optional(string)
      id             = string
      member         = string
      name           = optional(string)
      project_id     = optional(string)
      project_number = optional(string)
      unique_id      = optional(string)
    })))
    service_agents = optional(map(object({
      email          = optional(string)
      id             = string
      member         = optional(string)
      project_id     = optional(string)
      project_number = optional(string)
      service        = optional(string)
    })))
  })
  validation {
    condition     = length(var.project.project_id) >= 6 && length(var.project.project_id) <= 30 && can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.project.project_id))
    error_message = "The project ID must be between 6 and 30 characters, including the suffix, and can only contain lowercase letters, digits, and hyphens. It must start with a letter and cannot end with a hyphen."
  }

  validation {
    condition = alltrue([
      contains(keys(var.project.project_services), "artifactregistry.googleapis.com")
    ])
    error_message = "The project_services map must include the artifactregistry.googleapis.com service."
  }
}

variable "region" {
  description = "The region where Cloud Run service will be deployed"
  type        = string
  default     = "europe-west1"
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

