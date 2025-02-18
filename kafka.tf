# Create a namespace for observability
resource "kubernetes_namespace" "kafka-namespace" {
    depends_on = [ null_resource.kubectl ]
    metadata {
        name = "kafka"
    }
}


# Helm chart for Strimzi Kafka
resource "helm_release" "strimzi-cluster-operator" {
  name = "strimzi-cluster-operator"  
  repository = "https://strimzi.io/charts/"
  chart = "strimzi-kafka-operator"
  version = "0.42.0"
  namespace = kubernetes_namespace.kafka-namespace.metadata[0].name
  depends_on = [kubernetes_namespace.kafka-namespace]
}