provider "aws" {
	region = "us-east-1"
}

resource "aws_db_instance" "example" {
	identifier_prefix = "terraform-db"
	engine = "mysql"
	allocated_storage = 10
	instance_class = "db.t2.micro"
	name = "example_database"
	username = "admin"
	password = "mypassword"
}

terraform {
	backend "s3" {
		bucket = "my-terraform-bucket-npsoni2"
		key = "dev/data-stores/mysql/terraform.tfstate"
		region = "us-east-1"

		#dynamo db locking
		dynamodb_table = "tf-state-locks"
		encrypt = true
	}
}