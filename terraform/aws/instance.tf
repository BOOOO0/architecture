# jenkins 서버, WS-1, WS-2, WAS-1, WAS-2
# jenkins - public-subnet-b

resource "aws_instance" "jenkins" {
  subnet_id = aws_subnet.public_subnet_b.id

  ami = var.amazon_linux_2023_ami
  instance_type = var.t3_medium
  key_name = var.ec2_key

  vpc_security_group_ids = [ aws_security_group.jenkins_sg.id ]
  
  user_data = file("./script/jenkins.sh")

  tags = {
    Name = "jenkins"
  }
}

resource "aws_instance" "ws_1" {
  subnet_id = aws_subnet.private_subnet_a.id

  ami = var.amazon_linux_2023_ami
  instance_type = var.t3_micro

  key_name = var.ec2_key

  vpc_security_group_ids = [ aws_security_group.ws_sg.id ]
  
  user_data = file("./script/ws.sh")

  tags = {
    Name = "ws-1"
  }
}

resource "aws_instance" "ws_2" {
  subnet_id = aws_subnet.private_subnet_b.id

  ami = var.amazon_linux_2023_ami
  instance_type = var.t3_micro

  key_name = var.ec2_key

  vpc_security_group_ids = [ aws_security_group.ws_sg.id ]
  
  user_data = file("./script/ws.sh")

  tags = {
    Name = "ws-2"
  }
}

resource "aws_instance" "was_1" {
  subnet_id = aws_subnet.private_subnet_a_2.id

  ami = var.amazon_linux_2023_ami
  instance_type = var.t3_micro

  key_name = var.ec2_key

  vpc_security_group_ids = [ aws_security_group.was_sg.id ]
  
  user_data = file("./script/ws.sh")

  tags = {
    Name = "was-1"
  }
}

resource "aws_instance" "was_2" {
  subnet_id = aws_subnet.private_subnet_b_2.id

  ami = var.amazon_linux_2023_ami
  instance_type = var.t3_micro

  key_name = var.ec2_key

  vpc_security_group_ids = [ aws_security_group.was_sg.id ]
  
  user_data = file("./script/was.sh")

  tags = {
    Name = "was-2"
  }
}