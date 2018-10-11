resource "aws_s3_bucket" "log_bucket" {
  bucket = "${local.LOG_BUCKET_NAME}"
  policy = "${data.aws_iam_policy_document.bucket_policy.json}"

  tags = {
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }

  force_destroy = true # turn this off for production!!!

  //  lifecycle {
  //    prevent_destroy = true
  //  }

  lifecycle_rule {
    id      = "log-expiration"
    enabled = "true"

    expiration {
      days = "7"
    }
  }
}
