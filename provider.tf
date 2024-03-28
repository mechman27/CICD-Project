terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.22.0"
    }
  }
}
provider "google" {
  project     = "secure-granite-397514"
  region      = "us-west1"
  zone        = "us-west1-b"
  credentials = "./secure-granite-397514-7221b0ef8b7f.json"
}