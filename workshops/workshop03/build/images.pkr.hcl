variable DO_token {
    type = string
    sensitive = true
}

source digitalocean mydroplet {
    api_token = var.DO_token
    image = "ubuntu-20-04-x64"
    size = "s-2vcpu-4gb"
    region = "sgp1"
    ssh_username = "root"
    snapshot_name = "day03-workshop03"
}

build {
    sources = [ "source.digitalocean.mydroplet" ]

    provisioner ansible {
        playbook_file = "playbook.yaml"
    }
}