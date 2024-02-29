locals {
  publicsubnets = [var.public_subnet_a_id, var.public_subnet_b_id]
  privatesubnets = [var.private_subnet_a_id, var.private_subnet_b_id]
}

resource "aws_instance" "web_pub_servers" {
    
    for_each = var.web_vm_attribute
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [var.ssh_security_group_id]
    key_name = each.value.key_name
    subnet_id = local.publicsubnets[index(keys(var.web_vm_attribute), each.key) % length(local.publicsubnets)]                                      
    tags = {
      Name =  "web_${each.value.name}"
    }
}


resource "aws_instance" "pri_servers" {
    for_each = var.pri_vm_attribute
    
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [var.ssh_security_group_id]
    key_name = each.value.key_name
    subnet_id = local.privatesubnets[index(keys(var.pri_vm_attribute), each.key) % length(local.privatesubnets)]
    tags = {
      Name = each.value.name
    }
}
