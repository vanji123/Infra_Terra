terraform {
  backend "s3" {
    bucket = "mytestbucvanji"
    key    = "state"
    region = "us-east-1"
    dynamodb_table = "mytab"
  }
}
