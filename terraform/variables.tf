variable "db_password" {
  description = "Database password supplied securely at deployment time"
  type        = string
  sensitive   = true
}