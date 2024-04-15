resource "aws_launch_configuration" "web_lc" {
  name          = "web-server-lc"
  image_id      = var.image_id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow_web.id]
  #user_data = var.ec2_user_data
  key_name = "piyush_test"
  user_data = file("user_data.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name                 = "web-server-asg2"
  launch_configuration = aws_launch_configuration.web_lc.name
  desired_capacity     = 1
  min_size             = 1
  max_size             = 2
  
  vpc_zone_identifier  = ["${element(aws_subnet.web_vpc_subnet.*.id, 0)}"]

  tag {
    key                 = "Name"
    value               = "Web_Server-instance"
    propagate_at_launch = true
  }
  tag {
    key                 = "ASG"
    value               = "web_asg"
    propagate_at_launch = true
  }
}

# ASG Scaling Policy (Example: Scale Out on High CPU)

resource "aws_autoscaling_policy" "web_cpu_scaling" {
  name           = "web-server-cpu-scaling"
  autoscaling_group_name =  "${element(aws_autoscaling_group.web_asg.*.id , 0)}" # aws_autoscaling_group.web_asg.name
  policy_type    = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value          = 70.0
  }

}


output "alb_public_url" {
  description = "Public URL for Application Load Balancer"
  value       = aws_lb.web_balancer.dns_name
}