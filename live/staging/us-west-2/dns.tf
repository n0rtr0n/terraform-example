resource "aws_route53_record" "s" {
  zone_id = "${data.terraform_remote_state.global.hosted_zone_id}"
  name    = "staging.${data.terraform_remote_state.global.hosted_zone_name}"
  type    = "A"

  alias {
    name                   = "${module.alb.alb_dns_address}"
    zone_id                = "${module.alb.zone_id}"
    evaluate_target_health = true
  }
}

