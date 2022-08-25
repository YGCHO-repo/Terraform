# # ++++++++++++++++++++++++++++++++++++++++++++++
# #                   ALB Listener
# # ++++++++++++++++++++++++++++++++++++++++++++++
# #                     Front
# # ++++++++++++++++++++++++++++++++++++++++++++++
# resource "aws_lb_listener_rule" "front_alb_listener_rule" {
#   listener_arn = aws_lb_listener.front_alb_listener.arn

#   priority =                # 1~5000 숫자 값

#   action {

#     }

#   condition {

#   }

#   # tags = 
# }

# # ++++++++++++++++++++++++++++++++++++++++++++++
# #                    Backend
# # ++++++++++++++++++++++++++++++++++++++++++++++
# resource "aws_lb_listener_rule" "backend_alb_listener_rule" {
#   listener_arn = aws_lb_listener.backend_alb_listener.arn

#   priority =                # 1~5000 숫자 값

#   action {

#     }

#   condition {

#   }

#   # tags = 
# }
