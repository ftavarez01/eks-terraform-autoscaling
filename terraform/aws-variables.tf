# Define variable for AWS Region.
variable "region" {
  description = "The regions for AWS for deploy resources."
  type        = string
  default     = "us-east-2" # you can change the default value region us-east-2
}