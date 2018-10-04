terraform {
  required_version = "0.11.8"

  backend "s3" {
    encrypt        = true
    bucket         = "nn-tf-state-staging"
    dynamodb_table = "nn-lock-staging"
    key            = "us-west-2.tfstate"
    region         = "us-west-2"
  }
}
