resource "aws_lb_target_group" "main_hospital_target_group" {
  name     = "main-hospital-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.main_hospital_vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "ec2_apps" {
  count = length(var.ec2_app_ids)
  target_group_arn = aws_lb_target_group.main_hospital_target_group.arn
  target_id        = var.ec2_app_ids[count.index]
  port             = 80
}

resource "aws_lb" "main_hospital_alb" {
  name               = "main_hospital_alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = var.alb_security_group_ids
  subnets            = var.alb_subnet_ids

  enable_deletion_protection = false
}

resource "aws_lb_listener" "main_hospital_alb_listener" {
  load_balancer_arn = aws_lb.main_hospital_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main_hospital_target_group.arn
  }
}