
terraform {
  required_version = "~> 1.0.0"
}


locals {
  env = "dev"
}

provider "google" {
  project = "cloudbuild-ike"
}

/*resource "google_service_account" "sadev" {
  account_id   = "saaccountdev"
  display_name = "arindamsvcd"
}*/

resource "google_data_fusion_instance" "datafusion_instance" {
  name = "datafusion1"
  description = "My Data Fusion instance for test"
  region = "us-central1"
  type = "DEVELOPER"
  enable_stackdriver_logging = true
  enable_stackdriver_monitoring = true
  labels = {
    example_key = "example_value"
  }
  private_instance = false
  network_config {
    network = "default"
    ip_allocation = "10.89.48.0/22"
  }
  version = "6.3.0"
  dataproc_service_account = data.google_app_engine_default_service_account.default.email

  timeouts {
    create = "60m"
  }
}

data "google_app_engine_default_service_account" "default" {
}

