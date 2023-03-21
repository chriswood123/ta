module "ecs_cluster" {
  source = "./modules/ecs-cluster"
}

module "hello_service" {
  source = "./modules/hello-service"

  task_image_tag  = var.task_image_tag
  ecs_cluster     = module.ecs_cluster.cluster_arn
  service_subnets = data.aws_subnets.private_subnets.ids
  vpc_id          = data.aws_vpc.default_vpc.id
  lb_subnets      = data.aws_subnets.private_subnets.ids

  ecs_execution_role_policy_arn = "arn:aws:eu-west-1:ecs_execution_role_policy_arn:policy/AmazonECSTaskExecutionRolePolicy"
}

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_subnets" "private_subnets" {
  filter {
    name    = "vpc-id"
    values  = [data.aws_vpc.default_vpc.id]
  }
  filter {
    name    = "tag:Public"
    values  = ["true"]
  }
}