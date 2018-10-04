output "target_group_arns" {
  value = "${module.alb.target_group_arns}"
}

output "alb_dns_address" {
  value = "${module.alb.dns_name}"
}

output "load_balancer_id" {
  value = "${module.alb.load_balancer_id}"
}
