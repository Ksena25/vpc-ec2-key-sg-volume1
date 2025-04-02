
# Launch EC2 instance

resource "aws_instance" "server1" {
  ami  = "ami-02f624c08a83ca16f"   # Amazon Linux 2 (us-east-1)
  instance_type = "t2.micro"
  key_name = aws_key_pair.key1.key_name
  vpc_security_group_ids = [ aws_security_group.web_server_sg.id ]
  subnet_id = aws_subnet.pubsub1.id
  user_data = filebase64("setup.sh")

  tags = {
    Name = "Terraform_instance"
  }
}