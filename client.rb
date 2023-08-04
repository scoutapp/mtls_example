require 'net/http'
require 'net/https'
require 'uri'

client_cert_path = './client/client.crt'
client_key_path = './client/client.key'
server_ca_cert_path = './ca/ca.crt'

server_url = URI.parse('https://localhost:443/')

client_cert = OpenSSL::X509::Certificate.new(File.read(client_cert_path))
client_key = OpenSSL::PKey::RSA.new(File.read(client_key_path))

http = Net::HTTP.new(server_url.host, server_url.port)
http.use_ssl = true
http.cert = client_cert
http.key = client_key
http.ca_file = server_ca_cert_path

request = Net::HTTP::Get.new(server_url.request_uri)

response = http.request(request)

puts "Response Code: #{response.code}"
puts "Response Body: #{response.body}"
