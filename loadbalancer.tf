resource "aws_lb_target_group" "my_tg" { // Target Group A
  name     = "target-group-a"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

// Target group attachment
resource "aws_lb_target_group_attachment" "tg_attachment" {
  count            = 3
  target_group_arn = aws_lb_target_group.my_tg.arn
  target_id        = aws_instance.app-instance.*.id[count.index]
  port             = 80
}

resource "aws_lb" "app_alb" {
  name               = "myapp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = var.subnet_ids

  tags = tomap(
    {
      "Environment" = var.environment,
      "Name"        = "myapp",
    }
  )
}

resource "aws_lb_listener" "my_alb_listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}
