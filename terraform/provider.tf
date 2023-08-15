terraform {
  required_providers {
    ncloud = {
      source = "navercloudplatform/ncloud"
    }
  }
  required_version = ">= 0.13"
}

provider "ncloud" {
  support_vpc = true
  region      = "KR"
  access_key  = var.access_key
  secret_key  = var.secret_key
}
