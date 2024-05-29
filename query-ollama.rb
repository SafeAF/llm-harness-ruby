require 'net/http'
require 'uri'
require 'json'

# Specify the URL of your Ollama server's API endpoint
uri = URI('http://10.0.0.19:4000/api/generate')

# Prepare the data payload
data = {
  model: 'llama3',
  prompt: 'Why is the sky blue?'
}.to_json

# Create the HTTP objects
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
request.body = data

# Send the request
response = http.request(request)

# Print the response body
puts response.body

# Check if the response was successful
if response.is_a?(Net::HTTPSuccess)
  puts "POST request sent successfully!"
else
  puts "Failed to send POST request, response code: #{response.code}"
end
