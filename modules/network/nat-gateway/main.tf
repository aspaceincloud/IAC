# allocate elastic-ip. This ip will be used for nat-gateway in the az-a
resource "aws_eip" "eip_for_nat_gateway_az_a" {
    tags = {
        Name = "nat-gateway_az_a_eip"
    }
}

# allocate elastic-ip. This ip will be used for nat-gateway in the az-b
resource "aws_eip" "eip_for_nat_gateway_az_b" {
    tags = {
        Name = "nat-gateway_az_b_eip"
    }
}


# create nat gateway in public subnet az_a
resource "aws_nat_gateway" "nat_gateway_az_a" {
    allocation_id = aws_eip.eip_for_nat_gateway_az_a.id
    subnet_id = var.public_subnet_a_id

    tags = {
      Name = "nat-gateway_az_a"
    }

    depends_on = [ var.internet_gateway ]
}

# create nat gateway in public subnet az_b
resource "aws_nat_gateway" "nat_gateway_az_b" {
    allocation_id = aws_eip.eip_for_nat_gateway_az_b.id
    subnet_id = var.public_subnet_b_id

    tags = {
      Name = "nat-gateway_az_b"
    }

    depends_on = [ var.internet_gateway ]
}

# create private route table for az_a and add the route through nat-gateway_az_a
resource "aws_route_table" "private_route_table_az_a" {
    vpc_id = var.vpc_id

    route { 
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway_az_a.id

    }
   
   tags = {
    Name = "private route table az a"
   }

   depends_on = [aws_nat_gateway.nat_gateway_az_a]
}

# associate private subnets to private route table for az_a
resource "aws_route_table_association" "private_route_az_a" {
    subnet_id = var.private_subnet_a_id
    route_table_id = aws_route_table.private_route_table_az_a.id
}

# create private route table for az_b and add the route through nat-gateway_az_b
resource "aws_route_table" "private_route_table_az_b" {
    vpc_id = var.vpc_id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway_az_b.id
    }
   
   tags = {
    Name = "private route table az a"
   }
}

# associate private subnets to private route table for az_b
resource "aws_route_table_association" "private_route_az_b" {
    subnet_id = var.private_subnet_b_id
    route_table_id = aws_route_table.private_route_table_az_b.id
}