resource "aws_ecr_repository" "hello" {
  name = var.repository_name
}