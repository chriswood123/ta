resource "aws_lb" "hello" {
  name = "${var.service_name}-lb"
  internal  = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.lb.id]
  subnets = var.lb_subnets
}

resource "aws_lb_target_group" "hello" {
  name        = "${var.service_name}-lb-tg"
  port        = var.task_host_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.hello.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.hello.arn
  }
}

resource "aws_security_group" "lb" {
  name    = "${var.service_name}-lb-sg"
  vpc_id  = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.lb.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "80"
  to_port     = "80"
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_task_port" {
  security_group_id = aws_security_group.lb.id

  referenced_security_group_id = aws_security_group.hello.id

  from_port   = var.task_host_port
  to_port     = var.task_host_port
  ip_protocol = "tcp"
}