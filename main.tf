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

resource "google_cloudbuildv2_connection" "main" {
  project  = var.project_id
  location = var.region
  name     = var.github_connection.name

  github_config {
    app_installation_id = var.github_connection.app_installation_id

    authorizer_credential {
      oauth_token_secret_version = var.github_connection.oauth_token_secret_version
    }
  }
}

resource "google_cloudbuildv2_repository" "repo" {
  project = var.project_id

  for_each          = { for repo in var.repositories : repo.name => repo }
  name              = each.value.name
  location          = var.region
  parent_connection = google_cloudbuildv2_connection.main.name
  remote_uri        = each.value.remote_uri

  depends_on = [google_cloudbuildv2_connection.main]

}

resource "google_cloudbuild_trigger" "repo_trigger" {
  for_each = { for idx, trigger in var.triggers : idx => trigger }

  location        = var.region
  project         = var.project_id
  name            = each.value.name
  service_account = "projects/${var.project_id}/serviceAccounts/${var.service_account_email}"

  repository_event_config {
    repository = google_cloudbuildv2_repository.repo[each.value.repository_id].id

    push {
      tag = each.value.tag_pattern
    }
  }

  filename   = each.value.filename
  depends_on = [google_cloudbuildv2_repository.repo]
}

