# Input Variables - Placeholder file
# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-west-2"  
}
# Environment Variable
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "staging"
}
# Business Division
variable "business_divsion" {
  description = "Business Division in the large organization this Infrastructure belongs"
  type = string
  default = "argo-workflow-nim"
}

# Business Division
variable "cluster_id" {
  description = "The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts"
  type = string
  default = "staging-nim-engines"
}

variable "aws_iam_openid_connect_provider_arn" {
  description = "The ARN assigned by AWS for this provider/data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn"
  type = string
  default = ""
}

variable "eks_cluster_endpoint" {
  description = "The hostname (in form of URI) of Kubernetes master/data.terraform_remote_state.eks.outputs.cluster_endpoint"
  type = string
  default = ""
}

variable "eks_cluster_certificate_authority_data" {
  description = "PEM-encoded root certificates bundle for TLS authentication./data.terraform_remote_state.eks.outputs.cluster_certificate_authority_data"
  type = string
  default = ""
}