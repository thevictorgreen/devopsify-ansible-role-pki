#!/bin/bash

# GET FQDN
read -p "Enter username : " fqdn
mkdir /root/ca/requests/${fqdn}

# CREATE THE PRIVATE KEY
openssl genrsa -out /root/ca/requests/${fqdn}/${fqdn}.pem 2048

# CREATE THE CONFIG FILE
cat <<EOF >> /root/ca/requests/${fqdn}/req.conf
[req]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no
[req_distinguished_name]
C = US
ST = TN
L = Hermitage
O = Deloitte and Touche LLP
CN = $fqdn
[v3_req]
keyUsage = keyEncipherment, dataEncipherment, digitalSignature, keyAgreement, nonRepudiation
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = $fqdn
EOF

# CREATE THE CSR
openssl req -new -key /root/ca/requests/${fqdn}/${fqdn}.pem -out /root/ca/requests/${fqdn}/${fqdn}.csr -config /root/ca/requests/${fqdn}/req.conf

# SIGN THE REQUEST
openssl ca -in /root/ca/requests/${fqdn}/${fqdn}.csr -out /root/ca/requests/${fqdn}/${fqdn}.crt
