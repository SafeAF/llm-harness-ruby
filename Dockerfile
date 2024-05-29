FROM ruby:3.1

# Install any necessary packages, if required
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set the working directory
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install the gems
RUN bundle install

# Copy the rest of the application code
COPY . ./

# Expose the port that Ollama will run on
EXPOSE 9292

# Command to start Ollama (replace with the actual command you use to start Ollama)
CMD ["puma", "-C", "config/puma.rb"]
