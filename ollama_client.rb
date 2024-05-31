require 'net/http'
require 'uri'
require 'json'

def query_ollama(uri, prompt)
  # Prepare the data payload
  data = {
    model: 'llama3:latest',
    prompt: prompt
  }.to_json

  # Create the HTTP objects
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
  request.body = data

  # Send the request and collect the response
  response = http.request(request)

  # Check if the response was successful
  if response.is_a?(Net::HTTPSuccess)
    # Initialize an empty string to collect the responses
    full_response = ""

    # Split the response body into lines (assuming each line is a JSON object)
    response.body.each_line do |line|
      begin
        # Parse each line as JSON
        json_response = JSON.parse(line)
        # Append the 'response' field to the full_response string
        full_response += json_response['response']
      rescue JSON::ParserError => e
        puts "Failed to parse line: #{line}"
        puts "Error: #{e.message}"
      end
    end

    # Print the formatted response
    puts "Response from Ollama:\n\n#{full_response}"
  else
    puts "Failed to send POST request, response code: #{response.code}"
  end
end
