region="us-east-1"
project_name="project-A"
vpc_cidr="10.0.0.0/16"
public_subnet_a_cidr="10.0.0.0/24"
public_subnet_b_cidr="10.0.1.0/24"
private_subnet_a_cidr="10.0.2.0/24"
private_subnet_b_cidr="10.0.3.0/24"
ami= "ami-0440d3b780d96b29d"
instance_type= "t2.micro"
web_vm_attribute={
  pub_a = {
      name = "pub_a"
      key_name = "for_terra"
        }
  pub_b = {
        name = "pub_b"
        key_name = "for_terra"
      }
   
}
pri_vm_attribute={

  pri_a = {
        name = "pri_a"
        key_name = "for_terra"
  }
  pri_b = {
        name = "pri_b"
        key_name = "for_terra"
      }
} 
