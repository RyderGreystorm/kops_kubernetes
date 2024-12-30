cidr               = "10.0.0.0/16"
availability_zones = ["us-east-1a", "us-east-1b"]
pub-cidr           = ["10.0.1.0/24", "10.0.2.0/24"]
pub-key            = "../key_pair/mykey.pub"
priv-key           = "../key_pair/mykey"
instance-type      = "t3.medium"
volume-size        = 25
REGION             = "us-east-1"