terraform {
  backend "gcs" {
    bucket = "cloudbuild-ike-tfstate"
    prefix = "env/prod"
  }
}
