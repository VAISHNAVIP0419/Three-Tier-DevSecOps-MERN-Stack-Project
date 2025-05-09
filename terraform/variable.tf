variable "vpc_id" {
  description = "VPC ID"
  default     = "vpc-0a57822b15100e18f"  # Your VPC ID
}

variable "subnet_ids" {
  description = "Subnet IDs"
  default = [
    "subnet-0520c3fa6c0451794",
    "subnet-03f973d59ed405bbd",
    "subnet-055d25c03ce19fe0b"
  ]
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  default     = "vaishnavi-eks"
}
