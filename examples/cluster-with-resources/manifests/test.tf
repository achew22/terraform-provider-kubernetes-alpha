variable "name" {}
variable "cluster_name" {}

resource "kubernetes_manifest" "test-cfm" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind" = "ConfigMap"
    "metadata" = {
      "name" = var.name
      "namespace" = "default"
      "labels" = {
        "parent_cluster" = var.cluster_name
      }
    }
    "data" = {
      "parent_cluster" = var.cluster_name
    }
  }
}
