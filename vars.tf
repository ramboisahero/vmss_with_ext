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

######

variable "url" {
  type = string
  default = "https://dev.azure.com/AnandRaju0153"
  description = "Specify the Azure DevOps url"
}

variable "pat" {
  type = string
  default = "nq3sugspbfiv4lpx4skjxhyy53vi3slbh257clgdhl2cka6uxofa"
  description = "Provide a Personal Access Token (PAT) for Azure DevOps"
}

variable "pool" {
  type = string
  default = "Default"
  description = "Name of the agent pool - must exist before"
}

#The name of the agent
variable "agent" {
  type = string
  default = "myagent01"
  description = "Specify the name of the agent"
}

variable "pyenv_cmd" {
  type = string
  default = "sudo /usr/local/bin/pyenv install 3.7.9"
}