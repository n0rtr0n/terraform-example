variable ENVIRONMENT {}
variable LOGGING_ENABLED {}
variable LOG_BUCKET_NAME {}
variable LOG_LOCATION_PREFIX {}
variable LOAD_BALANCER_NAME {}

variable SECURITY_GROUPS {
  type = "list"
}

variable SUBNETS {
  type = "list"
}

variable VPC_ID {}

variable HTTP_TCP_LISTENERS {
  type = "list"
}

variable HTTP_TCP_LISTENERS_COUNT {}

variable HTTPS_LISTENERS {
  type = "list"
}

variable HTTPS_LISTENERS_COUNT {}

variable TARGET_GROUPS {
  type = "list"
}

variable TARGET_GROUPS_COUNT {}

variable TAGS {
  type = "map"
}
