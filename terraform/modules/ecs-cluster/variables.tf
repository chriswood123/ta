variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "cluster"
}

variable "fargate_provider_strategy_weight" {
  description = "The weight to be used in the fargate provider strategy"
  type        = number
  default     = 100
}

variable "fargate_provider_strategy_base" {
  description = "The base to be used in the fargate provider strategy"
  type        = number
  default     = 1
}