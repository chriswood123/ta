resource "aws_ecs_service" "hello" {
  name            = var.service_name
  cluster         = var.ecs_cluster
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.hello.arn
  desired_count   = var.service_desired_count


  network_configuration {
    subnets           = var.service_subnets
    security_groups   = [aws_security_group.hello.id]
    assign_public_ip  = true
  }

  load_balancer {
    target_group_arn  = aws_lb_target_group.hello.arn
    container_name    = "hello"
    container_port    = var.task_host_port
  }
}

resource "aws_security_group" "hello" {
  name    = "${var.service_name}-sg"
  vpc_id  = var.vpc_id
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_task_port" {
  security_group_id = aws_security_group.hello.id

  referenced_security_group_id = aws_security_group.lb.id

  from_port   = var.task_host_port
  to_port     = var.task_host_port
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "allow_https" {
  security_group_id = aws_security_group.hello.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = "443"
  to_port     = "443"
  ip_protocol = "tcp"
}