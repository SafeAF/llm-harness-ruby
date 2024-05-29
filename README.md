# llm-harness-ruby
Playing around with calling Ollama in Ruby


# Setup

Build container
`docker build -t ollama-app .`


Run ollama container with an exposed port
`docker run -d -p 9292:9292 --name ollama-container ollama-app
`

Verify container is running
`docker ps`

From your laptop, you can now make requests to Ollama at http://<DOCKER_HOST_IP>:9292.