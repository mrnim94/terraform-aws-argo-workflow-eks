# output "aws_iam_openid_connect_provider_arn" {
#   description = "aws_iam_openid_connect_provider_arn"
#   value = "arn:aws:iam::${element(split(":", "${data.aws_eks_cluster.k8s.arn}"), 4)}:oidc-provider/${element(split("//", "${data.aws_eks_cluster.k8s.identity[0].oidc[0].issuer}"), 1)}"
# }

# Resource: IAM Policy for Cluster Autoscaler
resource "aws_iam_policy" "irsa_iam_policy" {
  name        = "${local.name}-ArgoWorkflowPolicy"
  path        = "/"
  description = "Argo Workflow Policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::${local.name}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ],
            "Resource": "arn:aws:s3:::${local.name}/*"
        }
    ]
  })
}

#data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn
#data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn

# Resource: Create IAM Role and associate the EBS IAM Policy to it
resource "aws_iam_role" "irsa_iam_role" {
  name = "${local.name}-irsa-iam-role"

  # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "${var.aws_iam_openid_connect_provider_arn}"
        }
        Condition = {
          StringLike = {            
            "${local.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:argo-workflow:argoworkflow-mdaas-staging-argo-workflows-*"
          }
        }        

      },
    ]
  })

  tags = {
    tag-key = "${local.name}-irsa-iam-role"
  }
}

# Associate IAM Role and Policy
resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach" {
  policy_arn = aws_iam_policy.irsa_iam_policy.arn 
  role       = aws_iam_role.irsa_iam_role.name
}

output "irsa_iam_role_arn" {
  description = "IRSA Demo IAM Role ARN"
  value = aws_iam_role.irsa_iam_role.arn
}