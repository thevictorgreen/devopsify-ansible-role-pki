#!/bin/bash
read -p "Enter server fqdn or username of existing keypair: " fqdn
openssl x509 -in /root/ca/requests/${fqdn}/${fqdn}.crt -noout -text
