resource "aws_db_subnet_group" "db_subnet_group" {
  
  name = "db-subnet-group"

  subnet_ids = [ aws_subnet.db_subnet_a.id, aws_subnet.db_subnet_b.id ]

  tags = {
    Name = "db-subnet-group"
  }
}

# 지금 해봐야할 것은 이 RDS에 마스터 사용자로 다른 인스턴스가 접근할 수 있는지
# 마스터 사용자를 쓰는 것은 좋은 방법이 아니지만 권한을 주는 별도의 과정이 필요가 없어서
# DB 서버에 직접적인 접근을 최소화할 수 있다.

resource "aws_db_instance" "my_db" {
  identifier = "my-db"

  storage_type = "gp3"
  allocated_storage = 100

  engine = "mariadb"
  engine_version = "10.11.6"
  instance_class = "db.t3.small"
  # default db name
  db_name = "apidb"
  # master user
  username = "root"
  password = "rds!!#root123"

  multi_az = true

  skip_final_snapshot = true

  vpc_security_group_ids = [ aws_security_group.db_sg.id ]
  
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
}