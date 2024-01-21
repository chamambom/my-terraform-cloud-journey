# Create a Remote Backend
terraform {
  backend "s3" {
    #profile = "122634593747_SystemAdministrator"
    bucket = "terra-iac"
    key    = "demo/instance/terraform.tfstate"
    
  }
}

provider "aws" {
#access_key = var.AWS_ACCESS_KEY
#secret_key = var.AWS_SECRET_KEY
#token = var.AWS_SESSION_TOKEN
#region = var.DEFAULT_REGION
  
}

resource "aws_instance" "app_server" {
  ami           = "ami-063a9ea2ff5685f7f"
  instance_type = "t3.micro"

  tags = {
    Name = "RemoteStateInstance"
  }
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}