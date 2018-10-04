resource "aws_s3_bucket" "state_bucket" {
  bucket = "${var.STATE_BUCKET_NAME}"
  region = "${var.AWS_REGION}"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "S3 Remote Terraform State Store"
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "state_lock" {
  name           = "${var.STATE_LOCKING_TABLE}"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name        = "DynamoDB Terraform State Lock Table - ${var.ENVIRONMENT}"
    Terraform   = "true"
    Environment = "${var.ENVIRONMENT}"
  }

  lifecycle {
    prevent_destroy = true
  }
}
