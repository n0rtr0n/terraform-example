variable AWS_PROFILE {}

variable AWS_REGION {
  default = "us-west-2"
}

variable DOMAIN_NAME {}
variable EC2_INSTANCE_SIZE {}
variable ENVIRONMENT {}

# Amazon Linux 2
variable EXAMPLE_ASG_AMIS {
  type = "map"

  default = {
    us-east-1 = "ami-04681a1dbd79675a5"
    us-west-1 = "ami-0782017a917e973e7"
    us-west-2 = "ami-6cd6f714"
  }
}

variable LOG_BUCKET_NAME {}
variable LOG_LOCATION_PREFIX {}
variable PUBLIC_KEY {}
