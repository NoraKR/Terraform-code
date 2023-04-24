#!/bin/bash

# Update the package repository
sudo yum update -y

# Install Java 11
sudo amazon-linux-extras install java-openjdk11 -y

# Import the Jenkins repository key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Add the Jenkins repository to the system
sudo sh -c 'echo -e "[jenkins]\nname=Jenkins\nbaseurl=https://pkg.jenkins.io/redhat-stable/\ngpgcheck=1" > /etc/yum.repos.d/jenkins.repo'

# Install Jenkins
sed -i 's/gpgcheck=1/gpgcheck=0/g'   /etc/yum.repos.d/jenkins.repo
sudo yum install jenkins -y

# Start and enable the Jenkins service
sudo systemctl start jenkins
sudo systemctl enable jenkins                              
                              
*** ec2.tf
resource "aws_instance" "Jenkins-server" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  user_data     = file("jenkins.sh")
  subnet_id     = module.vpc-jenkins.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  tags ={
    Name = var.name
    environment = var.env 
  }

}                           