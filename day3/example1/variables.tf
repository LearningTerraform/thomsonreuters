variable "region" {
  # default = "ap-south-1"
  description = "My default region"
}

variable "ami" {
  default = {
    us-east-1 = "ami-00068cd7555f543d5"
    ap-south-1 = "ami-0ce933e2ae91880d3"

  }
  # default = ["ami-00068cd7555f543d5","ami-second", "third-ami"]
  description = "AMI to be used in us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
  description = "Default instance type for us-east-1"
}
