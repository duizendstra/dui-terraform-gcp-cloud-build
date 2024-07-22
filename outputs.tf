output "repositories" {
  description = "List of created repositories"
  value = { for k, v in google_cloudbuildv2_repository.repo : k => {
    name       = v.name
    location   = v.location
    remote_uri = v.remote_uri
    id         = v.id
  } }
}