output "address" {
	value = aws_db_instance.example.address
	description = "Address of the MySQL database"
}

output "port" {
	value = aws_db_instance.example.port
	description = "The MySQL database port"
}