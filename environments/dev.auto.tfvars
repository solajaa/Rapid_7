instance_type = "t2.micro"
ami_id        = "ami-0b5eea76982371e91"
api_key       = "ABLKCKUEHLKSFNKUEJ"
security_group_ingress = {
  "80 ingress rule" = {
    "description" = "For HTTP"
    "from_port"   = "80"
    "to_port"     = "80"
    "protocol"    = "tcp"
    "cidr_blocks" = ["0.0.0.0/0"]
  },
  "22 ingress rule" = {
    "description" = "For SSH"
    "from_port"   = "22"
    "to_port"     = "22"
    "protocol"    = "tcp"
    "cidr_blocks" = ["0.0.0.0/0"]
  },
  "443 ingress rule" = {
    "description" = "For HTTPS"
    "from_port"   = "443"
    "to_port"     = "443"
    "protocol"    = "tcp"
    "cidr_blocks" = ["0.0.0.0/0"]
  }
}

security_group_egress = {
  "443 ingress rule" = {
    "description" = "Egress"
    "from_port"   = "0"
    "to_port"     = "0"
    "protocol"    = "tcp"
    "cidr_blocks" = ["0.0.0.0/0"]
  }
}
