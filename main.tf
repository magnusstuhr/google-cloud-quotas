terraform {
  required_providers {
    google-beta = {
      source = "hashicorp/google-beta"
      version = "~> 5.12.0"
    }
  }
}

provider "google-beta" {
  project = var.project
  region  = var.region
}

resource "google_service_usage_consumer_quota_override" "query_usage_per_day_per_project" {
  provider       = google-beta
  project        = var.project  
  service        = "bigquery.googleapis.com"
  metric         = urlencode("bigquery.googleapis.com/quota/query/usage")
  limit          = urlencode("/d/project")
  override_value = "100000000"
  force          = true
}

resource "google_service_usage_consumer_quota_override" "query_usage_per_day_per_user" {
  provider       = google-beta
  project        = var.project  
  service        = "bigquery.googleapis.com"
  metric         = urlencode("bigquery.googleapis.com/quota/query/usage")
  limit          = urlencode("/d/project/user")
  override_value = "50000000"
  force          = true
}
