variable "AWS_REGION" {
  default = "us-west-2"
}

variable "AWS_PROFILE" {}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
  }
}
