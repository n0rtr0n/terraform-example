resource "aws_route53_zone" "that" {
  name = "${var.DOMAIN_NAME}"
}
