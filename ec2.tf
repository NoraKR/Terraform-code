resource "aws_instance" "demo1" {
    ami = "ami-0b0dcb5067f052a63"
    instance_type = "t2.micro"
    user_data = file("${path.module}/postgresql.sh")
    tags = {
      "Name" = "Postgresql-server"
      "env"  = "dev"
    }
}                  