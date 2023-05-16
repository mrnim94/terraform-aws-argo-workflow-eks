# Install Cluster Autoscaler using HELM

# Resource: Helm Release 
resource "helm_release" "argo_workflow_release" {
  depends_on = [aws_iam_role.irsa_iam_role ]            
  name       = "${lower(local.name)}-ca"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-workflows"

  namespace = "argo-workflow"

#   set {
#     name  = "controller.workflowDefaults.spec.serviceAccountName"
#     value = "aws"
#   }

#   set {
#     name  = "autoDiscovery.clusterName"
#     value = var.eks_cluster_id
#   }

#   set {
#     name  = "awsRegion"
#     value = var.aws_region
#   }

#   set {
#     name  = "rbac.serviceAccount.create"
#     value = "true"
#   }

#   set {
#     name  = "rbac.serviceAccount.name"
#     value = "cluster-autoscaler"
#   }

#   set {
#     name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = "${aws_iam_role.cluster_autoscaler_iam_role.arn}"
#   }
#   # Additional Arguments (Optional) - To Test How to pass Extra Args for Cluster Autoscaler
#   #set {
#   #  name = "extraArgs.scan-interval"
#   #  value = "20s"
#   #}  

#   set {
#     name  = "nodeSelector.kubernetes\\.io/os"
#     value = "linux"
#   }  
   
}