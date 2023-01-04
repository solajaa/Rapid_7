# Define variables for the security group
variable "security_group_name" {
  type    = string
  default = "rapid7"
}

variable "security_group_description" {
  type    = string
  default = "rapid7"

}

variable "instance_type" {
  type = string
}

# Define a variable for the API key
variable "api_key" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "security_group_ingress" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "security_group_egress" {
  type = map(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}