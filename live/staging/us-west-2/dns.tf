//resource "aws_route53_record" "tf" {
//  zone_id = "${data.terraform_remote_state.global.hosted_zone_id}"
//  name    = "tf.${data.terraform_remote_state.global.hosted_zone_name}"
//  type    = "A"
//  ttl     = 300
//  records = ["123.132.231.101"]
//}

