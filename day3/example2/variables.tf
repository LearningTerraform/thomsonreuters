variable "users" {
  description = "Users that need to have IAM users"
  default = ["nishant","avinash", "matrix","lathika"]
}

variable "test" {
  type = set(string)
  default = ["nishant", "avi", "xyz"]
}
