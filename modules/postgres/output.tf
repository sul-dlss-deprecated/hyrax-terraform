output "EndpointAddress" {
  value = "${aws_db_instance.postgresql.address}"
}

output "EndpointPort" {
  value = "${aws_db_instance.postgresql.port}"
}

output "DatabaseName" {
  value = "${var.DatabaseName}"
}
