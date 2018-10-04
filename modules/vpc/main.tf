provider "aws" {
  profile = "${var.AWS_PROFILE}"
  region  = "${var.AWS_REGION}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "1.44.0"

  name = "${var.NAME}"
  cidr = "${var.CIDR_BLOCK}"

  azs             = "${var.AZS}"
  private_subnets = "${var.PRIVATE_SUBNETS}"
  public_subnets  = "${var.PUBLIC_SUBNETS}"

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  tags = {
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }
}
