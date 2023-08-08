#!/bin/bash

#####
## CA
#####

# Create the CA key and certificate for signing leaf Certs
openssl req -new   -x509  -nodes  -days 365  -subj '/CN=my-ca'  -keyout ca/ca.key  -out ca/ca.crt -sha256

#####
## Server
#####

# Create the server private key
openssl genrsa -out server/server.key 2048

# Create the server certificate signing request (CSR)
openssl req -new -key server/server.key -subj '/CN=localhost' -out server/server.csr -sha256

# Use the CA key to sign the server CSR and get back the signed certificate
openssl x509 -req -in server/server.csr -CA ca/ca.crt -CAkey ca/ca.key -CAcreateserial -out server/server.crt -days 365 -sha256

#####
## Client
#####

# Create the client private key
openssl genpkey -algorithm RSA -out client/client.key

# Create the client certificate signing request (CSR)
openssl req -new -key client/client.key -subj '/CN=client' -out client/client.csr -sha256

# Use the CA key to sign the client CSR and get back the signed certificate
openssl x509 -req -in client/client.csr -CA ca/ca.crt -CAkey ca/ca.key -CAcreateserial -out client/client.crt -days 365 -sha256

# Create a combined PEM file for the client cert and key
cat client/client.crt client/client.key > client/combined.pem
