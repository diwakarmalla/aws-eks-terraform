# Kafka Monitoring with Prometheus
Configure your AWS credentials using below command:
```
aws configure
```
Deploy EKS cluster using below terragrunt commands

```
terragrunt run-all init
terragrunt run-all plan
terragrunt run-all apply
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

Access Prometheus/Grafana UI using loadbalancer URL:port

Consumer pods will wait for 5min after reading each message. 

Validate consumer lag using kafka_consumergroup_lag metric in Prometheus and check consumer pods count in kafka namespace



