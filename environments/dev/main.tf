
terraform {
  required_version = "~> 1.0.0"
}


locals {
  env = "dev"
}

provider "google" {
  project = "cloudbuild-ike"
}

terraform {
  required_providers {
    cdap = {
      source = "GoogleCloudPlatform/cdap"
      version = "0.10.0"
    }
  }
}

provider "cdap" {
  # Configuration options
}

/*resource "google_service_account" "sadev" {
  account_id   = "saaccountdev"
  display_name = "arindamsvcd"
}*/

resource "google_data_fusion_instance" "datafusion_instance5" {
  name = "datafusion5"
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


 }


data "google_app_engine_default_service_account" "default" {
}

resource "cdap_application" "pipeline" {
    name = "example_pipeline"
    spec = file("${path.module}/datapipe.json")
}


