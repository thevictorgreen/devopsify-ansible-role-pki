#!/bin/bash

openssl req -new -x509 -key /root/ca/private/cakey.pem -out /root/ca/cacert.pem -days 3650 -config /root/ca/req.conf

