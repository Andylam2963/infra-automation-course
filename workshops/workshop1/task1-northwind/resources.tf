
# network
resource "docker_network" "mynet" {
  name = "my_network"
}

# volume

resource docker_volume nwdb-vol {
    name = "nwdb-vol"
}

# db

resource docker_image mydb {
    name = "stackupiss/northwind-db:v1"
}

resource docker_container mydb-container {
    name = "mydb"
    image = docker_image.mydb.name
    ports {
        internal = 3306
        external = 3306
    }
    networks_advanced {
        name = docker_network.mynet.name
    }
    volumes {
        volume_name = docker_volume.nwdb-vol.name
        container_path = "/var/lib/mysql"
    }
}

# application

resource docker_image myapp {
    name = "stackupiss/northwind-app:v1"
}

resource docker_container myapp-container {
    name = "myapp-01"
    image = docker_image.myapp.name
    env = [
        "DB_HOST=${docker_container.mydb-container.name}",
        "DB_USER=root",
        "DB_PASSWORD=changeit"
    ]
    ports {
        internal = 3000
        external = 80
    }
    networks_advanced {
        name = docker_network.mynet.name
    }
}

output mydb_id {
    value = resource.docker_container.myapp-container.env
}

output mydb_ip {
    value = resource.docker_container.mydb-container.ip_address
}
