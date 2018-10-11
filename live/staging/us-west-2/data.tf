data "terraform_remote_state" "global" {
  backend = "s3"

  config {
    bucket  = "nn-tf-state-global"
    region  = "us-west-2"
    key     = "global.tfstate"
    profile = "${var.AWS_PROFILE}"
  }
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "aws_region" "current" {}

data "aws_elb_service_account" "main" {}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid       = "AllowToPutLoadBalancerLogsToS3Bucket"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${local.LOG_BUCKET_NAME}/${var.LOG_LOCATION_PREFIX}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_elb_service_account.main.id}:root"]
    }
  }
}

data "template_file" "user_data" {
  template = "${file("scripts/init.sh")}"
}
