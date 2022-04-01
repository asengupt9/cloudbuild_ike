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
    spec = file("${path.module}/pipeline.json")
   /* spec = jsonencode({
    "name": "testpipeline",
    "description": "Data Pipeline Application",
    "artifact": {
        "name": "cdap-data-pipeline",
        "version": "6.3.0",
        "scope": "SYSTEM"
    },
    "config": {
        "resources": {
            "memoryMB": 2048,
            "virtualCores": 1
        },
        "driverResources": {
            "memoryMB": 2048,
            "virtualCores": 1
        },
        "connections": [
            {
                "from": "BigQuery",
                "to": "Pub/Sub"
            }
        ],
        "comments": [],
        "postActions": [],
        "properties": {},
        "processTimingEnabled": true,
        "stageLoggingEnabled": false,
        "stages": [
            {
                "name": "BigQuery",
                "plugin": {
                    "name": "BigQueryTable",
                    "type": "batchsource",
                    "label": "BigQuery",
                    "artifact": {
                        "name": "google-cloud",
                        "version": "0.16.0",
                        "scope": "SYSTEM"
                    },
                    "properties": {
                        "referenceName": "OrderDataset.BQTable",
                        "project": "cloudbuild-ike",
                        "datasetProject": "cloudbuild-ike",
                        "dataset": "OrderDataset",
                        "table": "BQTable",
                        "enableQueryingViews": "false",
                        "serviceAccountType": "filePath",
                        "serviceFilePath": "auto-detect",
                        "schema": "{\"type\":\"record\",\"name\":\"bigquerySchema\",\"fields\":[{\"name\":\"ITEM_ID\",\"type\":[\"string\",\"null\"]},{\"name\":\"ITEM_DESC\",\"type\":[\"string\",\"null\"]},{\"name\":\"STOCK\",\"type\":[\"long\",\"null\"]},{\"name\":\"TOTAL_SALES\",\"type\":[\"long\",\"null\"]},{\"name\":\"STOCKDATE\",\"type\":[\"string\",\"null\"]}]}"
                    }
                },
                "outputSchema": [
                    {
                        "name": "etlSchemaBody",
                        "schema": "{\"type\":\"record\",\"name\":\"bigquerySchema\",\"fields\":[{\"name\":\"ITEM_ID\",\"type\":[\"string\",\"null\"]},{\"name\":\"ITEM_DESC\",\"type\":[\"string\",\"null\"]},{\"name\":\"STOCK\",\"type\":[\"long\",\"null\"]},{\"name\":\"TOTAL_SALES\",\"type\":[\"long\",\"null\"]},{\"name\":\"STOCKDATE\",\"type\":[\"string\",\"null\"]}]}"
                    }
                ],
                "id": "BigQuery",
                "type": "batchsource",
                "label": "BigQuery",
                "icon": "fa-plug"
            },
            {
                "name": "Pub/Sub",
                "plugin": {
                    "name": "GooglePublisher",
                    "type": "batchsink",
                    "label": "Pub/Sub",
                    "artifact": {
                        "name": "google-cloud",
                        "version": "0.16.0",
                        "scope": "SYSTEM"
                    },
                    "properties": {
                        "referenceName": "test",
                        "project": "auto-detect",
                        "topic": "bqdatatopic",
                        "serviceAccountType": "filePath",
                        "serviceFilePath": "auto-detect",
                        "messageCountBatchSize": "100",
                        "requestThresholdKB": "1",
                        "publishDelayThresholdMillis": "1",
                        "retryTimeoutSeconds": "30",
                        "errorThreshold": "0"
                    }
                },
                "outputSchema": [
                    {
                        "name": "etlSchemaBody",
                        "schema": "{\"type\":\"record\",\"name\":\"bigquerySchema\",\"fields\":[{\"name\":\"ITEM_ID\",\"type\":[\"string\",\"null\"]},{\"name\":\"ITEM_DESC\",\"type\":[\"string\",\"null\"]},{\"name\":\"STOCK\",\"type\":[\"long\",\"null\"]},{\"name\":\"TOTAL_SALES\",\"type\":[\"long\",\"null\"]},{\"name\":\"STOCKDATE\",\"type\":[\"string\",\"null\"]}]}"
                    }
                ],
                "inputSchema": [
                    {
                        "name": "BigQuery",
                        "schema": "{\"type\":\"record\",\"name\":\"bigquerySchema\",\"fields\":[{\"name\":\"ITEM_ID\",\"type\":[\"string\",\"null\"]},{\"name\":\"ITEM_DESC\",\"type\":[\"string\",\"null\"]},{\"name\":\"STOCK\",\"type\":[\"long\",\"null\"]},{\"name\":\"TOTAL_SALES\",\"type\":[\"long\",\"null\"]},{\"name\":\"STOCKDATE\",\"type\":[\"string\",\"null\"]}]}"
                    }
                ],
                "id": "Pub-Sub",
                "type": "batchsink",
                "label": "Pub/Sub",
                "icon": "fa-plug"
            }
        ],
        "schedule": "0 * * * *",
        "engine": "spark",
        "numOfRecordsPreview": 100,
        "maxConcurrentRuns": 1
    }
})*/

depends_on = [google_data_fusion_instance.datafusion_instance7]
}




