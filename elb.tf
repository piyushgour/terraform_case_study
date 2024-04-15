# Load Balancer
resource "aws_lb" "web_balancer" {
  name               = "web-load-balancer1"
  internal           = false
  security_groups    = [aws_security_group.allow_web.id]
  subnets            = [for subnet in aws_subnet.web_vpc_subnet : subnet.id]
  

}

# Target Group for Load Balancer
resource "aws_lb_target_group" "web_server" {
  name     = "web-server-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.web_vpc.id

  health_check {
    timeout         = 5
    interval         = 30
    unhealthy_threshold = 2
    healthy_threshold = 2
    path             = "/"
    port             = "8080"
  }
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_balancer.arn
  port = 8080
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_server.arn
  }

}

data "aws_instances" "web_server_data" {
  filter {
  name   = "tag:aws:autoscaling:groupName"
  values = ["web-server-asg2"]
}
  
}

# Attach Autoscaling Group to Target Group
resource "aws_lb_target_group_attachment" "web_server" {
  for_each =toset(data.aws_instances.web_server_data.ids)
  target_group_arn = aws_lb_target_group.web_server.arn
  target_id         = each.value
  port             = 8080
}
