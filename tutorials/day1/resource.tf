data "digitalocean_ssh_key" "andy-ub" {
    name = "andy-ub"
}

resource local_file andy-ub_public_key {
    filename = "andy.pub"
    content = data.digitalocean_ssh_key.andy-ub.public_key
    file_permission = "0644"
}

output andy-ub_ssh_key_fingerprint {
    value = data.digitalocean_ssh_key.andy-ub.fingerprint
}

output andy-ub_ssh_key_id {
    value = data.digitalocean_ssh_key.andy-ub.id
}


/*---*/

data docker_image dov-bear {
    name = "chukmunnlee/dov-bear:v2"
}

# iterative resource creation using count
resource docker_container dov-bear-container {
    count = length(var.ports)
    name = "dov-bear-${count.index}"
    image = data.docker_image.dov-bear.id
    env = [
        "INSTANCE_NAME=myapp",
        "INSTANCE_HASH=123a-${count.index}",
    ]
    ports {
        internal = 3000
        external = var.ports[count.index]
    }
}

# for_each resource creation
resource docker_container dov-bear-unique {
    for_each = var.containers
    name = each.key
    image = data.docker_image.dov-bear.id
    env = [
        "INSTANCE_NAME=myapp",
        "INSTANCE_HASH=123a-${each.key}",
    ]
    ports {
        internal = 3000
        external = each.value.external_port
    }
}

resource local_file container-name {
    content = "${join(", ", [ for c in docker_container.dov-bear-container: c.name])}"
    filename = "container-names.txt"
    file_permission = "0644"
}

output dov-bear-md5 {
    value = data.docker_image.dov-bear.repo_digest
    description = "SHA of the image"
}


output container-names {
    value = [for c in docker_container.dov-bear-container: c.name]
}