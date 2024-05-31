require_relative 'ollama_client'
#Specify the URL of your Ollama server's API endpoint
uri = URI('http://10.0.0.19:4000/api/generate')


class Character
  attr_reader :name, :role, :first_statement

  def initialize(name, role, first_statement, personality_prompt)
    @name = name
    @role = role
    @first_statement = first_statement
    @personality_prompt = personality_prompt
  end

  def speak(prompt)
    full_prompt = "#{@personality_prompt}\n\n#{prompt}"
    query_ollama(URI('http://10.0.0.19:4000/api/generate'), full_prompt)
  end
end



# Define the characters
locke = Character.new("John Locke", "Empirical Philosopher", 
                      "I, John Locke, assert that all our knowledge is derived from our experiences. The mind at birth is a blank slate, and it is through sensory experiences and reflection that we come to understand the world around us. There are no innate ideas; all ideas come from experience.",
                      "You are John Locke, an influential philosopher known for your empirical approach to knowledge. You believe that all knowledge comes from sensory experience and that the mind at birth is a blank slate or tabula rasa. Your arguments are grounded in the idea that knowledge is built through experience and reflection. You emphasize the importance of observation and evidence in forming ideas and reject the notion of innate ideas. Engage in the discussion by emphasizing the empirical basis of knowledge and the importance of experience in the acquisition of ideas.")

descartes = Character.new("René Descartes", "Rationalist Philosopher",
                          "I, René Descartes, argue that reason is the primary source of knowledge. Certain ideas, such as the concept of God and the principles of mathematics, are innate and exist within the mind from birth. Through methodical doubt and rational inquiry, we can achieve certain and indubitable knowledge. Experience alone cannot account for the knowledge we possess.",
                          "You are René Descartes, a renowned philosopher known for your rationalist approach to knowledge. You believe that reason is the primary source of knowledge and that certain ideas are innate, existing in the mind from birth. You argue that through methodical doubt and rational inquiry, we can achieve certain knowledge. You emphasize the importance of reason and deduction in understanding the world. Engage in the discussion by emphasizing the role of reason and innate ideas in the acquisition of knowledge and challenge the notion that all knowledge comes from experience.")

# Set the number of exchanges
num_exchanges = 5

# Function to manage the conversation
def have_conversation(character1, character2, num_exchanges)
  prompt = character1.first_statement
  while(1)
    puts "#{character1.name} (#{character1.role}):"
    response1 = character1.speak(prompt)
    puts "#{response1}\n\n"
    
    prompt = response1  # Pass the response as the next prompt for the other character
    
    puts "#{character2.name} (#{character2.role}):"
    response2 = character2.speak(prompt)
    puts "#{response2}\n\n"

    prompt = response2  # Pass the response as the next prompt for the first character
  end
end

# Start the conversation
have_conversation(locke, descartes, num_exchanges)


