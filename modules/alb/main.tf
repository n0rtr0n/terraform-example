module "alb" {
  # https://github.com/terraform-aws-modules/terraform-aws-alb for usage and list of outputs
  source  = "terraform-aws-modules/alb/aws"
  version = "3.4.0"

  logging_enabled             = "${var.LOGGING_ENABLED}"
  log_bucket_name             = "${var.LOG_BUCKET_NAME}"
  log_location_prefix         = "${var.LOG_LOCATION_PREFIX}"
  load_balancer_name          = "${var.LOAD_BALANCER_NAME}"
  security_groups             = "${var.SECURITY_GROUPS}"
  subnets                     = "${var.SUBNETS}"
  vpc_id                      = "${var.VPC_ID}"
  http_tcp_listeners          = "${var.HTTP_TCP_LISTENERS}"
  http_tcp_listeners_count    = "${var.HTTP_TCP_LISTENERS_COUNT}"
  https_listeners             = "${var.HTTPS_LISTENERS}"
  https_listeners_count       = "${var.HTTPS_LISTENERS_COUNT}"
  target_groups               = "${var.TARGET_GROUPS}"
  target_groups_count         = "${var.TARGET_GROUPS_COUNT}"
  tags                        = "${var.TAGS}"
  listener_ssl_policy_default = "ELBSecurityPolicy-TLS-1-1-2017-01"
}
