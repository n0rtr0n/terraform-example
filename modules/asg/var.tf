variable ASG_AMI {}
variable ASG_NAME {}
variable DESIRED_CAPACITY {}
variable EC2_INSTANCE_TYPE {}
variable ENVIRONMENT {}
variable KEY_NAME {}
variable LAUNCH_CONFIGURATION_NAME {}
variable MIN_SIZE {}
variable MAX_SIZE {}
variable NAME {}

variable SUBNETS {
  type = "list"
}

variable SECURITY_GROUPS {
  type = "list"
}

variable TARGET_GROUP_ARNS {
  type = "list"
}

variable USER_DATA {}
variable VOLUME_SIZE {}

variable VOLUME_TYPE {
  default = "gp2"
}
