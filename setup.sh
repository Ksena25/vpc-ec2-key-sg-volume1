
#!/bin/bash
sudo yum update -y
sudo groupadd docker
sudo seradd John -aG docker 
sudo yum install git unzip wget httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo cd /opt
sudo get https://github.com/kserge2001/web-consulting/archive/refs/heads/dev.zip
sudo unzip dev.zip
sudo cp -r /opt/web-consulting-dev/* /var/www/html
