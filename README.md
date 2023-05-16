# Argo Workflow on EKS

I have designed Argo Work on EKS to save logs and all artifact types on S3.

You can follow the below configuration:

```hcl

variable "aws_region" {
  description = "Please enter the region used to deploy this infrastructure"
  type        = string
  default = "us-west-2"  
}

variable "cluster_id" {
  description = "Enter full name of EKS Cluster"
  type        = string
  default = "dev-nim-engines" 
}

#Load informations of your EKS cluster
data "aws_eks_cluster" "eks_k8s" {
  name = var.cluster_id
}

module "argo-workflow-eks" {
  source  = "mrnim94/argo-workflow-eks/aws"
  version = "0.0.6"

  aws_region = var.aws_region
  environment = "dev"
  business_divsion = "argowf-nim"
  
  eks_cluster_certificate_authority_data = data.aws_eks_cluster.eks_k8s.certificate_authority[0].data
  eks_cluster_endpoint = data.aws_eks_cluster.eks_k8s.endpoint
  eks_cluster_id = var.cluster_id
  aws_iam_openid_connect_provider_arn = "arn:aws:iam::${element(split(":", "${data.aws_eks_cluster.eks_k8s.arn}"), 4)}:oidc-provider/${element(split("//", "${data.aws_eks_cluster.eks_k8s.identity[0].oidc[0].issuer}"), 1)}"
}

```

Example input:

```
eks_cluster_certificate_authority_data = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSRlgvZndHRmMKeU13PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg=="
eks_cluster_endpoint = "https://54BDECE91CB74A3682E45D44CB7533CE.gr7.us-west-2.eks.amazonaws.com"
eks_cluster_id = "dev-nim-engines"
aws_iam_openid_connect_provider_arn = "arn:aws:iam::250887682577:oidc-provider/oidc.eks.us-west-2.amazonaws.com/id/54BDECE91CB74A3682E45D44CB7533CE"
```