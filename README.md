# Kafka Monitoring with Prometheus
Configure your AWS credentials using below command:
```
aws configure
```
Deploy EKS cluster using below terragrunt commands

```
terragrunt init
terragrunt plan
terragrunt apply
```
Create docker registry secret using below command:
```
kubectl create secret docker-registry regcred --docker-server=docker.io --docker-username=<username> --docker-password=<password> --docker-email=<email> -n kafka
```
Deploy kafka-monitoring helm chart using below command:
```
helm install kafka-monitoring ./kafka-monitoring
```

Validate Resources deployed in below namespaces

```
kafka - Kafka cluster, topics, users
observability- Prometheus, Grafana and Pod Moitors
keda - Keda Resources
```

Consumer will sleep for 5min after reading each message. Please validate consumer lag and consumer resource scaling



