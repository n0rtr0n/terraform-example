terraform {
  required_version = "0.11.8"

  backend "s3" {
    bucket         = "nn-tf-state-global"
    dynamodb_table = "nn-lock-global"
    key            = "global.tfstate"
    region         = "us-west-2"
  }
}
