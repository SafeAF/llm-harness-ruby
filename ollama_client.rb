# ollama_client.rb
require 'net/http'
require 'uri'
require 'json'

def query_ollama(uri, prompt)
  # Prepare the data payload
  data = {
    model: 'llama3:latest',
    prompt: "#{prompt}\n\nPlease draw upon the whole of their collective works to make your arguments. Do the absolute best you can. Make it interesting. Keep the conversation lively and varied. Have them discuss everything from their philosophies to current issues to ancient or even unresolved issues in philosophy."
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

    # Return the formatted response
    truncate_response(full_response)
  else
    "Failed to send POST request, response code: #{response.code}"
  end
end

def truncate_response(response)
  sentences = response.split('.')
  truncated_response = sentences.first(3).join('. ')
  truncated_response += '.' unless truncated_response.end_with?('.')
  truncated_response
end
