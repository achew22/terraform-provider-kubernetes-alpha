variable "server_side_planning" {}
variable "name" {}
variable "namespace" {}


resource "kubernetes_manifest" "test-ns" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Namespace"
    "metadata" = {
      "name" = var.namespace
    }
  }
}

resource "kubernetes_manifest" "test-cfm" {
  provider = kubernetes-alpha

  manifest = {
    apiVersion = "v1"
    kind = "ConfigMap"
    metadata = {
	    name = var.name
	    namespace = kubernetes_manifest.test-ns.object.metadata.name
    }
    data = {
      foo = "bar"
    }
  }
}
