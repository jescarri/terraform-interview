variable "subnet_ids" {
  type    = list(any)
  default = ["subnet-16252e62", "subnet-7ed2391b", "subnet-e60c26a0"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-3d3fdf58"
}

variable "environment" {
  default = "lab1"
}
