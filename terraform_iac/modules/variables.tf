variable "cidr" {
  description = "vpc cidr range"
  type = string
}

variable "availability_zones" {
  description = "availability zones to occupy"
  type = list(string)
}

variable "pub-cidr" {
    description = "cidr range for public subnets"
  type = list(string)
}

variable "pub-key" {
  type = string
  description = "public key"
}

variable "priv-key" {
  type = string
  description = "private key for the instance"
}

variable "instance-type" {
  type = string
  description = "aws instance type"
}

variable "volume-size" {
  description = "instance storage size"
  type = number
}