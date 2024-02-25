# create vpc
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true

    tags = {
        Name = "${var.project_name}-vpc"
    }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-igw"
    }
  
}

# use data sources to get all avaliability zones in the region
data "aws_availability_zones" "avaliable_zones" {}

# create public subnet "public_subnet_a"
resource "aws_subnet" "public_subnet_a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_a_cidr
    availability_zone = data.aws_availability_zones.avaliable_zones.names[0]
    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet_a"
    }
}

# create public subnet "public_subnet_b"
resource "aws_subnet" "public_subnet_b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_b_cidr
    availability_zone = data.aws_availability_zones.avaliable_zones.names[1]
    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet_b"
    }
}

# create route table and add public route
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet_gateway.id
    }

    tags = {
        Name = "public route table"
    }
}

# associate public subnets a to "public route table"
resource "aws_route_table_association" "public_subnet_a_route_table_association" {
  subnet_id = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

# associate public subnets b to "public route table"
resource "aws_route_table_association" "public_subnet_b_route_table_association" {
  subnet_id = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

# create private subnet a

resource "aws_subnet" "private_subnet_a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_a_cidr
    availability_zone = data.aws_availability_zones.avaliable_zones.names[0]
    map_public_ip_on_launch = false

    tags = {
        Name = "private subnet a"
    }

}

# create private subnet b

resource "aws_subnet" "private_subnet_b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_b_cidr
    availability_zone = data.aws_availability_zones.avaliable_zones.names[1]
    map_public_ip_on_launch = false
    
    tags = {
        Name = "private subnet a"
    }

}