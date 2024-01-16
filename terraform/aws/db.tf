resource "aws_db_instance" "my_db" {
  allocated_storage = 10
  engine = "mariadb"
  engine_version = "10.11.6"
  instance_class = "db.t3.micro"
}