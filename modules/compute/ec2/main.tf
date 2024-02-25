resource "aws_instance" "web_pub_servers" {
    
    for_each = var.web_vm_attribute
    
    ami = var.ami
    instance_type = var.instance_type
    vpc_security_group_ids = [var.ssh_security_group_id]
    key_name = each.value.key_name
    subnet_id = each.value.id
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
    subnet_id = var.private_subnet_a_id
    tags = {
      Name = each.value.name
    }
}
