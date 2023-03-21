resource "aws_ecs_task_definition" "hello" {
  family                    = var.task_family
  requires_compatibilities  = ["FARGATE"]
  network_mode              = "awsvpc"
  cpu                       = var.task_cpu
  memory                    = var.task_memory
  execution_role_arn        = data.aws_iam_role.task_ecs.arn

  container_definitions = jsonencode([
    {
      name  = "hello"
      image = "${aws_ecr_repository.hello.repository_url}:${var.task_image_tag}"


      portMappings = [
        {
          containerPort = var.task_container_port
          hostPort      = var.task_host_port
        }
      ]
    }
  ])
}

data "aws_iam_role" "task_ecs" {
  name = "ecsTaskExecutionRole"
}
