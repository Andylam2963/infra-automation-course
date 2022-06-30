all:
  vars:
    ansible_connection: ssh
    codeserver_password: ${cs-password}
    codeserver_name: ${cs-name}
  hosts:
    code-server:
      ansible_host: ${host-ip}
      ansible_user: root
      ansible_ssh_private_key_file: ${host-pkey-path}