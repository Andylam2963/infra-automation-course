variable DO_token {
    type = string
    sensitive = true
}

variable DO_private_key {
    type = string 
    sensitive = true
}
variable DO_image {
    type = string
}
variable DO_region {
    type = string
    default = "sgp1"
}
variable DO_size {
    type = string
    default = "s-2vcpu-4gb"
}

variable CODESERVER_PASSWORD {
    type = string
}

variable CODESERVER_KEY_NAME {
    type = string
}
