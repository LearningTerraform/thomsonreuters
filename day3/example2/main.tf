provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "example" {
    for_each = var.test
    each.value == "avinash" ? brea : false
    name = each.value
}
