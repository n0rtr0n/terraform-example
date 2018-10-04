variable ENVIRONMENT {}
variable AWS_REGION {}
variable AWS_PROFILE {}

variable AZS {
  type = "list"
}

variable CIDR_BLOCK {
  default = "10.0.0.0/16"
}

variable NAME {
  default = "my-vpc"
}

variable PRIVATE_SUBNETS {
  type = "list"
}

variable PUBLIC_SUBNETS {
  type = "list"
}
