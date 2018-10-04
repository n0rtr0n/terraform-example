module "alb" {
  source = "../../../modules/alb"

  ENVIRONMENT              = "${var.ENVIRONMENT}"
  LOGGING_ENABLED          = true
  LOG_BUCKET_NAME          = "${aws_s3_bucket.log_bucket.id}"
  LOG_LOCATION_PREFIX      = "${var.LOG_LOCATION_PREFIX}"
  LOAD_BALANCER_NAME       = "${var.ENVIRONMENT}-alb"
  SECURITY_GROUPS          = ["${module.alb-security-group.this_security_group_id}", "${module.web-security-group.this_security_group_id}"]
  SUBNETS                  = ["${module.vpc.public_subnets}"]
  VPC_ID                   = "${module.vpc.vpc_id}"
  HTTP_TCP_LISTENERS       = "${local.HTTP_TCP_LISTENERS}"
  HTTP_TCP_LISTENERS_COUNT = "${local.HTTP_TCP_LISTENERS_COUNT}"
  TARGET_GROUPS            = "${local.TARGET_GROUPS}"
  TARGET_GROUPS_COUNT      = "${local.TARGET_GROUPS_COUNT}"

  TAGS = {
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }
}
