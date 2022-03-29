
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

resource "google_data_fusion_instance" "extended_instance" {
  name = "datafusion-test"
  description = "My Data Fusion instance"
  region = "us-central1"
  type = "DEVELOPER"
  enable_stackdriver_logging = true
  enable_stackdriver_monitoring = true
  labels = {
    example_key = "example_value"
  }
  private_instance = true
  network_config {
    network = "default"
    ip_allocation = "10.89.48.0/22"
  }
  version = "6.3.0"
  dataproc_service_account = saaccountdev@cloudbuild-ike.iam.gserviceaccount.com
}


