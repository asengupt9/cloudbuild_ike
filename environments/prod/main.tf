
terraform {
  required_version = "~> 1.0.0"
}


locals {
  env = "prod"
}

provider "google" {
  project = "cloudbuild-ike"
}

resource "google_service_account" "saprod" {
  account_id   = "saaccountprod"
  display_name = "arindamsvcp"
}
