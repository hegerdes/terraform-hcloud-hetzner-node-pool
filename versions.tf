terraform {
  required_version = ">= 1.0"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">=1.40"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.0"
    }
  }
}
