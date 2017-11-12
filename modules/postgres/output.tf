output "name" {
  value = "${aws_db_instance.postgresql.name}"
}

output "address" {
  value = "${aws_db_instance.postgresql.address}"
}

output "port" {
  value = "${aws_db_instance.postgresql.port}"
}

output "username" {
  value = "${aws_db_instance.postgresql.username}"
}
