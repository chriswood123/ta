resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_ecs_cluster_capacity_providers" "fargate" {
  cluster_name          = aws_ecs_cluster.cluster.name
  capacity_providers    = ["FARGATE"]

  default_capacity_provider_strategy {
    base                = var.fargate_provider_strategy_base
    weight              = var.fargate_provider_strategy_weight
    capacity_provider   = "FARGATE"
  }
}