region = "ap-northeast-2"

prefix = "test"

add_alb = {
  front = {
      name = "front-alb"
      target_type = "instance"
      port = 80
      protocol = "HTTP"
    },
    backend = {
      name = "backend-alb"
      target_type = "instance"
      port = 8080
      protocol = "HTTP"
    }
}

tags = {
    "CreatedByTerraform" = "True"
    "purpose"            = "Test"
    "owner"              = "Megazone"
    "resource"           = "ALB"
}





