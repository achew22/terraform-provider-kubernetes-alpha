variable "server_side_planning" {
  type = bool
}

provider "azurerm" {
  version = ">=2.20.0"
  features {}
}

provider "kubernetes-alpha" {
  server_side_planning = false #var.server_side_planning

  host = module.cluster.host
  cluster_ca_certificate = module.cluster.cluster_ca_certificate
  client_certificate = module.cluster.client_certificate
  client_key = module.cluster.client_key
}

resource "random_id" "uniq" {
  keepers = {
    api_host = module.cluster.host
  }

  byte_length = 2
}

module "cluster" {
  source = "./cluster"
}

module "manifests" {
  source = "./manifests"

  depends_on = [module.cluster]

  server_side_planning = var.server_side_planning
  name = "test-${random_id.uniq.hex}"
  namespace = "k8s-alpha-${random_id.uniq.hex}"
}