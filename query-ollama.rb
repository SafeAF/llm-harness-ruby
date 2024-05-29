require 'net/http'
require 'uri'
require 'json'

# Specify the URL of your Ollama server's API endpoint
uri = URI('http://localhost:4000/api/generate')

# Prepare the data payload
data = {
  model: 'llama3',
  prompt: 'Why is the sky blue?'
}.to_json

# Create the HTTP objects
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
request.body = data

# Send the request and collect the response
response = http.request(request)

# Check if the response was successful
if response.is_a?(Net::HTTPSuccess)
  # Parse the JSON response
  json_response = JSON.parse(response.body)
  
  # Collect all parts of the response
  full_response = json_response.map { |entry| entry['response'] }.join('')

  # Print the formatted response
  puts "Response from Ollama:\n\n#{full_response}"
else
  puts "Failed to send POST request, response code: #{response.code}"
end
