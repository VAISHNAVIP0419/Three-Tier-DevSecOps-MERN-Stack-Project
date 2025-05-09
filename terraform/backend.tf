terraform {
  backend "s3" {
    bucket = "your-unique-s3-bucket-name"  # Change the bucket name to match your manually created bucket
    key    = "terraform/state/eks-cluster.tfstate"
    region = "ap-south-1"
    dynamodb_table = "your-dynamodb-table"  # Change this to your DynamoDB table
    encrypt = true
  }
}
