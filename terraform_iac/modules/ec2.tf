data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("../key_pair/mykey.pub")
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance-type
  key_name = aws_key_pair.mykey.key_name
  subnet_id = aws_subnet.pub-sub[0].id
  vpc_security_group_ids = [ aws_security_group.kops-server-sg.id ]

  root_block_device {
    volume_size = var.volume-size
  }
  
  tags = {
    Name = "kops-server"
  }
}