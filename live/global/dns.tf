### WARNING!!! ###
# When this hosted zone is created, it will generate a set of new NS records - in order for a domain to be routed
# properly to this hosted zone, you will need to update the records in your DNS provider.  Alternatively, to make things
# much easier, this resource can simply be imported

resource "aws_route53_zone" "this" {
  name    = "${var.APEX_DOMAIN_NAME}"
}
