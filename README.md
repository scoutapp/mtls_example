# mTLS Example

Check out the _Securing Ruby Applications with mTLS_ article to learn more about this repo's contents, as well as deeper insights on troubleshooting.

* Medium: https://medium.com/@jrothrock/securing-ruby-applications-with-mtls-bc7a7d836038
* Dev.to: https://dev.to/scoutapm/securing-ruby-applications-with-mtls-1gen

## Scout:
Sign up today for a free trial with Scout APM for your application performance needs:

https://scoutapm.com

Also checkout TelemetryHub. A receiver and exploration tool for OpenTelemetry signals:

https://telemetryhub.com

## To Use:
1. `chmod +x create_certs.sh`

2. `./create_certs.sh`

3. `docker build -t mtls .`

4. `docker run -p 443:443 -it mtls`

5. In a separate terminal window: `curl https://localhost:443/ --cert ./client/client.crt --key ./client/client.key --cacert ./ca/ca.crt`

6. (Or) use the combined PEM file `curl https://localhost:443/ --cert ./client/combined.pem --cacert ./ca/ca.crt`

7. (Or) run the client.rb script: `ruby client.rb`

### Useful troubleshooting methods for the handshake
This shouldn't be needed for the above, but is useful for looking at the handshake:

1. Using cURL with the -vvv flag: `curl -vvv https://localhost:443/ --cert ./client/combined.pem --cacert ./ca/ca.crt`

2. Using s_client:  `openssl s_client -connect localhost:443 -key ./client/combined.pem -CAfile ./ca/ca.crt`
