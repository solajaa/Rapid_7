
# Create a security group
resource "aws_security_group" "my_sg" {
  name        = var.security_group_name
  description = var.security_group_description

  # Add the ingress rules
  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }


  # Add the egress rules
  dynamic "egress" {
    for_each = var.security_group_egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }
}

# Create an EC2 instance
resource "aws_instance" "my_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.my_sg.name]

  # Install the Rapid7 Insight Agent on the instance
   user_data = <<EOF
#!/bin/bash

# Install the Rapid7 Insight Agent
curl -s https://cloud.rapid7.com/linux/install | bash

# Configure the Rapid7 Insight Agent
echo "${data.template_file.insight_agent_conf.rendered}" > /etc/rapid7/insight-agent.conf
EOF

  # Add the EC2 instance to an Auto Scaling group
  lifecycle {
    create_before_destroy = true
  }

  # Configure the EC2 instance to be in a multi-AZ deployment
  availability_zone = data.aws_availability_zones.all.names[0]
  count             = 2
}



# Create a load balancer
resource "aws_elb" "my_elb" {
  name               = "my-elb"
  security_groups    = [aws_security_group.my_sg.id]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # Add the EC2 instances to the load balancer
  instances  = aws_instance.my_instance.*.id
  depends_on = [aws_instance.my_instance]
}
