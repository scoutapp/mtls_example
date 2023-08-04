# mTLS Example

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
6. (Or) use the combined PEM file `curl https://localhost:443/ --cert ./client/client.pem --cacert ./ca/ca.crt`
7. (Or) run the client.rb script: `ruby client.rb`

### Troubleshooting the handshake
1. Using cURL with the -vvv flag: `curl -vvv https://localhost:443/ --cert ./client/client.pem --cacert ./ca/ca.crt`
2. Using s_client:  `openssl s_client -connect localhost:443 -key ./client/client.pem -CAfile ./ca/ca.crt`
3. Wireshark w/ tcpdump.
   * Capture the packets between the two entities: `sudo tcpdump -i lo0 port 443 -w ./mtls.pcap`
   * Send a cURL request: `curl https://localhost:443/ --cert ./client/client.pem --cacert ./ca/ca.crt`
   * Exit the tcpdump session and open the written pcap file in Wireshark.
