terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "elasticsearch_instability_and_cluster_failures" {
  source    = "./modules/elasticsearch_instability_and_cluster_failures"

  providers = {
    shoreline = shoreline
  }
}