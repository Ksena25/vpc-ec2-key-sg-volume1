
resource "aws_security_group" "web_server_sg" {
  name        = "web-server-sg"
  description = "allow web traffic and SSH"
  vpc_id      = aws_vpc.vpc1.id

 
  ingress {
    from_port = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["24.46.88.191/32"]  ##Replace with your IP
    description = "SSH from specific IP" 
  } 

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP from everywhere"
  }

  # HTTPS access
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS from everywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"   ## all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags ={
    Name = "web-server-security_group"

 }
 depends_on = [ aws_vpc.vpc1 ]
}
