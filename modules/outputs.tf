output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "alb_dns_address" {
  value = "${module.alb.dns_name}"
}
