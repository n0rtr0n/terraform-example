resource "aws_s3_bucket" "log_bucket" {
  bucket        = "${local.log_bucket_name}"
  policy        = "${data.aws_iam_policy_document.bucket_policy.json}"
  force_destroy = true

  tags = {
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }

  lifecycle_rule {
    id      = "log-expiration"
    enabled = "true"

    expiration {
      days = "7"
    }
  }
}
