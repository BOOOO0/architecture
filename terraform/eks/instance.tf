resource "aws_instance" "master_node" {
  subnet_id = module.vpc.public_subnets[1]

  ami = var.amazon_2023
  instance_type = var.t3_medium
  key_name = var.ec2_key

  vpc_security_group_ids = [ aws_security_group.master_sg.id ]
  
  user_data = file("./script/master.sh")

  tags = {
    Name = "master-node"
  }
}

output "master_ip" {
  value = aws_instance.master_node.public_ip
}