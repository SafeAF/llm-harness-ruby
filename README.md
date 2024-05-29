# llm-harness-ruby
Playing around with calling Ollama in Ruby


# Setup

## Install docker

`sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt update
sudo apt install docker-ce`

## Build container
`docker build -t ollama-app .`


## Run ollama container with an exposed port
`docker run -d -p 9292:9292 --name ollama-container ollama-app
`

## Verify container is running
`docker ps`

From your laptop, you can now make requests to Ollama at http://<DOCKER_HOST_IP>:9292.


## Other useful docker commands

`docker inspect heuristic_davinci`

`docker logs heuristic_davinci`

`docker stop heuristic_davinci`

`docker run -d -p 10.0.0.19:8080:8080 ollama/ollama:latest`

`docker exec heuristic_davinci curl http://localhost:8080`

`docker rm heuristic_davinci`

`docker run -it --name heuristic_davinci --network host --entrypoint /bin/sh ollama/ollama:latest`
