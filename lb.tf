resource "aws_lb" "web_alb" {
  name               = "LoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.lb_security_group.id ]
  subnets            = [ aws_subnet.nat-a-subnet.id, aws_subnet.nat-b-subnet.id ]

}

resource "aws_lb_target_group" "web_lb_tg" {
  name        = "web-lb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.global_vpc.id
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "web-eu-a_tg_attachment" {
  target_group_arn = aws_lb_target_group.web_lb_tg.arn
  target_id        = aws_instance.web-eu-a.id # [ aws_instance.web-eu-a.id, aws_instance.web-eu-b.id ]
  port             = 80
}

resource "aws_lb_target_group_attachment" "web-eu-b_tg_attachment" {
  target_group_arn = aws_lb_target_group.web_lb_tg.arn
  target_id        = aws_instance.web-eu-b.id # [ aws_instance.web-eu-a.id, aws_instance.web-eu-b.id ]
  port             = 80
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn     = aws_lb_target_group.web_lb_tg.arn
        weight  = 1
      } 
    }
  }
}