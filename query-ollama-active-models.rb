require 'net/http'
require 'uri'
require 'json'

# Specify the URL of your Ollama server's API endpoint for listing models
uri = URI('http://localhost:4000/api/models')  # Adjust the endpoint based on the actual API

# Create the HTTP objects
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri, 'Content-Type' => 'application/json')

# Send the request
response = http.request(request)

# Check if the response was successful
if response.is_a?(Net::HTTPSuccess)
  # Parse the JSON response
  json_response = JSON.parse(response.body)

  # Print the list of models
  puts "Available models:"
  json_response.each do |model|
    puts "Model: #{model['name']}, ID: #{model['id']}, Size: #{model['size']}, Modified: #{model['modified']}"
  end

  # Additional logic to determine the active model can be added here if the API provides such information
else
  puts "Failed to retrieve models, response code: #{response.code}"
end
