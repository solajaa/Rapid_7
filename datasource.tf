# Retrieve a list of all available availability zones
data "aws_availability_zones" "all" {}


# Create a template file for the Rapid7 Insight Agent configuration
data "template_file" "insight_agent_conf" {
  template = <<EOF
api_key={{ api_key }}
EOF

  vars {
    api_key = "${var.api_key}"
  }
}