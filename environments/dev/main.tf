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


/*terraform {
  required_providers {
    cdap = {
      source = "GoogleCloudPlatform/cdap"
      version = "0.10.0"
    }
  }
}*/



/*resource "google_service_account" "sadev" {
  account_id   = "saaccountdev"
  display_name = "arindamsvcd"
}*/

resource "google_data_fusion_instance" "datafusion_instance7" {
  name = "datafusion7"
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
  dataproc_service_account = "790790594498-compute@developer.gserviceaccount.com"
 }

#data "google_app_engine_default_service_account" "default" {
#}

data "google_client_config" "current" {}

provider "cdap" {
  host  = "${google_data_fusion_instance.datafusion_instance7.service_endpoint}/api/"
  token = data.google_client_config.current.access_token
  # Configuration options
}


resource "cdap_application" "pipeline" {
    name = "example_pipeline"
    spec = file("${path.module}/pipeline_spec.json")
   
depends_on = [google_data_fusion_instance.datafusion_instance7]
}




