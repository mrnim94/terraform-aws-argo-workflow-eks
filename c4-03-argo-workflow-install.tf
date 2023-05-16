# Install Cluster Autoscaler using HELM

# Resource: Helm Release 
resource "helm_release" "argo_workflow_release" {
  depends_on = [aws_iam_role.irsa_iam_role ]            
  name       = "${lower(local.name)}"

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-workflows"

  namespace = "argo-workflow"

  set {
    name  = "controller.workflowDefaults.spec.serviceAccountName"
    value = "${lower(local.name)}-argo-workflows-workflow-controller"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.irsa_iam_role.arn}"
  }

  set {
    name  = "server.serviceAnnotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-internal"
    value = "'true'"
  }
  set {
    name  = "server.serviceType"
    value = "LoadBalancer"
  }
  set {
    name  = "server.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.irsa_iam_role.arn}"
  }
  set {
    name  = "server.extraArgs[0]"
    value = "--auth-mode=server"
  }
  set {
    name  = "useStaticCredentials"
    value = "true"
  }
  set {
    name  = "useDefaultArtifactRepo"
    value = "true"
  }
  set {
    name  = "artifactRepository.archiveLogs"
    value = "true"
  }
  set {
    name  = "artifactRepository.s3.bucket"
    value = "${lower(local.name)}"
  }
  set {
    name  = "artifactRepository.s3.endpoint"
    value = "s3.amazonaws.com"
  }
  set {
    name  = "artifactRepository.s3.region"
    value = var.aws_region
  }
  set {
    name  = "artifactRepository.s3.useSDKCreds"
    value = "true"
  } 
   
}