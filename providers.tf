provider "aws" {
  region = "${var.region}"
  access_key = "AKIAWJYUGLJXABEPRQ55"
  secret_key = "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"
}

terraform {
  backend "s3" {
    bucket = "dynamodb-bucket-tf"
    key    = "lockid"
    region = "eu-west-1"
  }
}
