resource "aws_s3_bucket" "argo-workflow" {
  bucket = "${local.name}"
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Description = "the artifact for Argo Workflow"
  }
}