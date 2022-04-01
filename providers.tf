provider "aws" {
  region = "${var.region}"
  access_key = "AKIAWJYUGLJXKNFVOOFW"
  secret_key = "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"
}

terraform {
  backend "s3" {
    bucket = "dynamodb-bucket-tf"
    key    = "lockid"
    region = "eu-west-1"
  }
}
