module "web-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.5.0"

  name        = "WebOpen"
  description = "Allows all traffic to HTTP port"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP Ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP Ports 8080"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "All ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }
}

module "alb-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.5.0"
  name    = "ALB"

  name        = "ALB-${var.ENVIRONMENT}"
  description = "Apply to Application Load Balancer"
  vpc_id      = "${module.vpc.vpc_id}"

  tags = {
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }
}

module "instance-security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "2.5.0"

  name        = "WebOpenFromALB-${var.ENVIRONMENT}"
  description = "Allows all traffic from ALB security group to HTTP port"
  vpc_id      = "${module.vpc.vpc_id}"

  computed_ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      source_security_group_id = "${module.alb-security-group.this_security_group_id}"
    },
  ]

  number_of_computed_ingress_with_source_security_group_id = 1

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "Nathan office IP"
      cidr_blocks = "174.27.20.230/32"
    },
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      description = "All ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

  tags = {
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }
}
