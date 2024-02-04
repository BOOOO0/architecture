resource "aws_lb" "my_lb_1" {
  
  name = "my-lb-1"

  load_balancer_type = "application"
  
  subnets = [ aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]

  security_groups = [ aws_security_group.lb_sg_1.id ]
  
}

resource "aws_lb_listener" "my_lb_1_listner" {
  load_balancer_arn = aws_lb.my_lb_1.arn

  port = 443
  protocol = "HTTPS"
  certificate_arn = aws_acm_certificate.cert.arn

  default_action {
    target_group_arn = aws_lb_target_group.my_lb_1_tg.arn
    type = "forward"
  }
}

resource "aws_lb_target_group" "my_lb_1_tg" {
  name = "my-lb-1-tg"
  port = 80
  protocol = "HTTP"

  vpc_id = aws_vpc.my_vpc.id

  health_check {
    path = "/health"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
  }
}

# 인스턴스에 attach하는 것
# 한번에 한 인스턴스밖에 안된다. id가 문자열로 받아져서
# 여러 인스턴스로 타겟그룹 하려면 이 attachment 리소스는 여러개 생성해야 한다.
resource "aws_lb_target_group_attachment" "my_lb_1_tg_attach_1" {
  target_group_arn = aws_lb_target_group.my_lb_1_tg.arn
  target_id = aws_instance.ws_1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "my_lb_1_tg_attach_2" {
  target_group_arn = aws_lb_target_group.my_lb_1_tg.arn
  target_id = aws_instance.ws_2.id
  port = 80
}

resource "aws_lb" "my_lb_2" {
  
  name = "my-lb-2"

  load_balancer_type = "application"
  
  subnets = [ aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]

  security_groups = [ aws_security_group.lb_sg_2.id ]
  
}

resource "aws_lb_listener" "my_lb_2_listner" {
  load_balancer_arn = aws_lb.my_lb_2.arn

  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.my_lb_2_tg.arn
    type = "forward"
  }
}

resource "aws_lb_target_group" "my_lb_2_tg" {
  name = "my-lb-2-tg"
  port = 8080
  protocol = "HTTP"
  
  vpc_id = aws_vpc.my_vpc.id

  health_check {
    path = "/health"
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
  }
}

resource "aws_lb_target_group_attachment" "my_lb_2_tg_attach_1" {
  target_group_arn = aws_lb_target_group.my_lb_2_tg.arn
  target_id = aws_instance.was_1.id
  port = 8080
}

resource "aws_lb_target_group_attachment" "my_lb_2_tg_attach_2" {
  target_group_arn = aws_lb_target_group.my_lb_2_tg.arn
  target_id = aws_instance.was_2.id
  port = 8080
}