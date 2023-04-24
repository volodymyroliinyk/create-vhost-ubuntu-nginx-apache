# create-vhost-ubuntu-nginx-apache
Shell script helps quickly create Ubuntu Apache host for any PHP based web project on your local machine.

- Don't use symbol "_" for local domain name.
- Open file `/etc/hosts` and add string `#localhost` to the end (one-time step).
- Run script under `root` user: `sudo -s;sh create_host_apache.sh <your-domain-name.local>;`