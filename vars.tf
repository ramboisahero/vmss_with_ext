variable "location" {
  type    = string
  default = "East US"
}

variable "numberOfWorkerNodes" {
  type = number
  default = 1
}

variable "ssh-source-address" {
  type    = string
  default = "*"
}

variable scfile{
    type = string 
    default = "/home/ec2-user/environment/vmss_with_ext/script.sh"
}

variable "computer_name" {
  default = "hostname"
}

# variable "admin_password" {
#   default = "Password@1234"
# }

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

