remote_state {
    backend = "s3"
    config = {
        bucket = "monitoring-terraform-aws-1"
        key = "${path_relative_to_include()}/tf.tfstate"
        region = "us-east-1"
        dynamodb_table = "eks-monitoring-aws-tfstate-new-lock"
    }
}