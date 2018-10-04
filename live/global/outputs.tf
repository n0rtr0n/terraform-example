output "hosted_zone_id" {
  value = "${aws_route53_zone.that.zone_id}"
}

output "hosted_zone_name" {
  value = "${aws_route53_zone.that.name}"
}
