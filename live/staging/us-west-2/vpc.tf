module "vpc" {
  source = "../../../modules/vpc"

  AWS_PROFILE     = "${var.AWS_PROFILE}"
  AWS_REGION      = "${var.AWS_REGION}"
  AZS             = "${local.AZS[var.AWS_REGION]}"
  CIDR_BLOCK      = "10.111.0.0/16"
  ENVIRONMENT     = "${var.ENVIRONMENT}"
  NAME            = "staging-vpc"
  PRIVATE_SUBNETS = ["10.111.1.0/24", "10.111.2.0/24", "10.111.3.0/24"]
  PUBLIC_SUBNETS  = ["10.111.101.0/24", "10.111.102.0/24", "10.111.103.0/24"]
}
