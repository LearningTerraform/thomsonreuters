resource "aws_vpc" "my-vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

    tags = var.vpc_tags
}

resource "aws_subnet" "subnets" {
    count = length(data.aws_availability_zones.azones.names)
    vpc_id     = aws_vpc.my-vpc.id
    #cidr_block = "10.0.0.${count.index*16}/26"
    cidr_block = element(var.subnet_cidr, count.index)
    availability_zone = element(data.aws_availability_zones.azones.names, count.index)

    tags = {
        Name = "Main"
  }
}