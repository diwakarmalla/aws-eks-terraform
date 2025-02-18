remote_state {
    backend = "s3"
    config = {
        bucket = "monitoring-terraform-aws-1"
        key = "us-east-1/monitoring/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "eks-monitoring-aws-tfstate-new-lock"
    }
}