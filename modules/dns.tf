resource "aws_route53_zone" "this" {
  name = "${var.DOMAIN_NAME}"
}

resource "aws_route53_record" "tf" {
  zone_id = "${aws_route53_zone.this.zone_id}"
  name    = "tf.${aws_route53_zone.this.name}"
  type    = "A"

  alias {
    name                   = "${module.alb.dns_name}"
    zone_id                = "${module.alb.load_balancer_zone_id}"
    evaluate_target_health = true
  }
}
