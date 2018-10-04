resource "aws_wafregional_ipset" "ipset" {
  name = "tfIPSet"

  ip_set_descriptor {
    type  = "IPV4"
    value = "192.0.7.0/24"
  }
}

resource "aws_wafregional_rule" "this" {
  name        = "tfWAFRule"
  metric_name = "tfWAFRule"

  predicate {
    data_id = "${aws_wafregional_ipset.ipset.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_web_acl" "this" {
  name        = "WAFRules"
  metric_name = "WAFRules"

  default_action {
    type = "ALLOW"
  }

  rule {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = "${aws_wafregional_rule.this.id}"
  }
}

resource "aws_wafregional_web_acl_association" "foo" {
  resource_arn = "${module.alb.load_balancer_id}"
  web_acl_id   = "${aws_wafregional_web_acl.this.id}"
}
