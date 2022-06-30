data digitalocean_ssh_key codeserver-key-name {
    name = var.CODESERVER_KEY_NAME
}

data "digitalocean_image" "workshop03-image" {
  name = var.DO_image
}

resource digitalocean_droplet workshop03 {
    name = "code-server"
    image = data.digitalocean_image.workshop03-image.id
    size = var.DO_size
    region = var.DO_region
    ssh_keys = [ data.digitalocean_ssh_key.codeserver-key-name.id ]
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
        cs-name = "code-${digitalocean_droplet.workshop03.ipv4_address}.nip.io"
        cs-password = var.CODESERVER_PASSWORD
        host-ip = digitalocean_droplet.workshop03.ipv4_address
        host-pkey-path = var.DO_private_key
    })
    filename = "inventory.yaml"
    file_permission = "0644"
}

resource local_file codeserver-host {
    content = ""
    filename = "root@${digitalocean_droplet.workshop03.ipv4_address}"
    file_permission = "0644"
}