resource "aws_security_group" "alb_sg" {
  name        = var.alb_security_group_name
  description = var.alb_security_group_description
  vpc_id      = var.existing_vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ingress_cidrs
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_ingress_cidrs
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.allowed_egress_cidrs
  }

  tags = merge(var.common_tags, {
    Name = var.alb_security_group_name
  })
}

resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_ids

  tags = merge(var.common_tags, {
    Name = var.alb_name
  })
}

resource "aws_lb_target_group" "app" {
  name        = var.app_tg_name
  port        = var.app_target_port
  protocol    = var.app_target_protocol
  vpc_id      = var.existing_vpc_id
  target_type = var.target_type

  health_check {
    enabled             = true
    protocol            = var.app_target_protocol
    path                = var.app_health_check_path
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = merge(var.common_tags, {
    Name = var.app_tg_name
  })
}

resource "aws_lb_target_group" "redis" {
  name        = var.redis_tg_name
  port        = var.redis_target_port
  protocol    = var.redis_target_protocol
  vpc_id      = var.existing_vpc_id
  target_type = var.target_type

  health_check {
    enabled             = true
    protocol            = var.redis_target_protocol
    path                = var.redis_health_check_path
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags = merge(var.common_tags, {
    Name = var.redis_tg_name
  })
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.alb_certificate_arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Host not configured"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "app_host_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }

  condition {
    host_header {
      values = [var.app_domain_name]
    }
  }
}

resource "aws_lb_listener_rule" "redis_host_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 110

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.redis.arn
  }

  condition {
    host_header {
      values = [var.redis_domain_name]
    }
  }
}
