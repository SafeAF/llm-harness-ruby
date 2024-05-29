# Query ollama container remotely

require 'net/http'
require 'uri'
require 'json'

# Replace with your Docker host's IP address
DOCKER_HOST_IP = '192.168.1.100'
SERVER_PORT = '9292'
ENDPOINT = "/api/v1/your_endpoint"

uri = URI.parse("http://#{DOCKER_HOST_IP}:#{SERVER_PORT}#{ENDPOINT}")

# Example of making a GET request
response = Net::HTTP.get(uri)
puts "Response: #{response}"

# Example of making a POST request with JSON payload
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, { 'Content-Type' => 'application/json' })
request.body = { key: 'value' }.to_json

response = http.request(request)
puts "Response: #{response.body}"
