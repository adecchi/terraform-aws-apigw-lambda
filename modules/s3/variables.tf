variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
  default     = "My Applications Buucket"
}

variable "key" {
  description = "The name of the object(file) once it is in the bucket"
  type        = string
  default     = "default-application.zip"
}

variable "source_path" {
  description = "The path to the file"
  type        = string
  default     = "../applications/default-application.zip"
}



