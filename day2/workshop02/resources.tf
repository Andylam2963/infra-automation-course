data digitalocean_ssh_key workshop02 {
    name = "workshop02"
}

resource digitalocean_droplet code-server {
    name = "code-server"
    image = var.DO_image
    size = var.DO_size
    region = var.DO_region
    ssh_keys = [ data.digitalocean_ssh_key.workshop02.id ]
    connection {
        type = "ssh"
        user = "root"
        private_key = file(var.DO_private_key)
        host = self.ipv4_address
    }
    provisioner remote-exec {
        inline = [
            "apt update"
        ]
    }
}

resource local_file code-server-details {
    content = templatefile("./inventory.yaml.tpl", {
        cs-name = "code-${digitalocean_droplet.code-server.ipv4_address}.nip.io"
        cs-password = var.CODESERVER_PASSWORD
        host-ip = digitalocean_droplet.code-server.ipv4_address
        host-pkey-path = var.DO_private_key
    })
    filename = "inventory.yaml"
    file_permission = "0644"
}