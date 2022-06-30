packer {
  required_plugins {
    digitalocean = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/digitalocean"
    }
    local = {
        source = "hashicorp/local"
        version = "latest"
    }
  }
}

provider digitalocean {
    token = var.DO_token
}