resource "kubernetes_namespace" "kafka-namespace" {
    depends_on = [ local-exec.update_kubeconfig ]
    metadata {
        name = "kafka"
    }
}

resource "helm_release" "keda" {
  name = "keda"

  repository       = "https://kedacore.github.io/charts"
  chart            = "keda"
  namespace        = "keda"
  version          = "2.10.1"
  create_namespace = true
}