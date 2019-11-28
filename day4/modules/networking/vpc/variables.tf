variable "vpc_cidr" {
  description = "CIDR Block for the vpc to be provided by the caller"
  default = "10.0.0.0/26"
}

variable "vpc_tags" {
  description = "Custom tags applied for each environment"
  type = map(string)
  default = {}
}

data "aws_availability_zones" "azones" {}

# variable "azones" {
#     default = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]  
# }


variable "subnet_cidr" {
    default = ["10.0.0.0/28", "10.0.1.0/28","10.0.2.0/28","10.0.3.0/28","10.0.4.0/28","10.0.5.0/28"]  
  
}
