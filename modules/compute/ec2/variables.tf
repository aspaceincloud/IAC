variable "ami" {}
variable "instance_type" {}
variable "ssh_security_group_id" {}
variable "public_subnet_a_id" {}
variable "public_subnet_b_id" {}
variable "private_subnet_a_id" {}
variable "private_subnet_b_id" {}
variable "web_vm_attribute" {
    type = map(object({
     name = string
     key_name = string
    }))

    default = {}
 }
 
variable "pri_vm_attribute" {
    type = map(object({
      name = string
      key_name = string
    }))

    default = {}
}
