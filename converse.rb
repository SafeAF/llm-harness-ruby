require_relative 'ollama_client'
#Specify the URL of your Ollama server's API endpoint
uri = URI('http://10.0.0.19:4000/api/generate')

class Character
  attr_reader :name, :role

  def initialize(name, role, personality_prompt)
    @name = name
    @role = role
    @personality_prompt = personality_prompt
  end

  def speak(prompt)
    full_prompt = "#{@personality_prompt}\n\n#{prompt}"
    query_ollama(full_prompt)
  end
end


# Define the characters
alice = Character.new("Alice", "Curious Explorer", "You are Alice, a curious explorer with a knack for asking deep and thought-provoking questions.")
bob = Character.new("Bob", "Wise Scholar", "You are Bob, a wise scholar with extensive knowledge and a calm demeanor. You provide insightful answers to questions.")

# Initialize the conversation
initial_prompt = "Why is the sky blue?"

# Set the number of exchanges
num_exchanges = 5

# Function to manage the conversation
def have_conversation(character1, character2, initial_prompt, num_exchanges)
  prompt = initial_prompt
  num_exchanges.times do |i|
    puts "#{character1.name} (#{character1.role}): #{prompt}"
    response = character1.speak(prompt)
    puts "#{character2.name} (#{character2.role}): #{response}\n\n"
    prompt = response
  end
end

# Start the conversation
have_conversation(alice, bob, initial_prompt, num_exchanges)



