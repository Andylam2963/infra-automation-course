
terraform {
  required_version = "> 1.2"
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.17.0"
    }
  }
}

provider "docker" {
  # Configuration options
  host = "unix:///var/run/docker.sock"
}
