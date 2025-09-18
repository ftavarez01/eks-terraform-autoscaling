# Define variable for AWS Region.
variable "region" {
  description = "The regions for AWS for deploy resourses."
  type        = string
  default     = "us-east-2" # you can change the default value region on aws
}