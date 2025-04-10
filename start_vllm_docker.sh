#!/bin/bash
# start_vllm_docker.sh - Script for running vLLM in Docker

# Make sure Docker and Docker Compose are installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Optional: Pull the latest image first
docker pull vllm/vllm-openai:v0.3.2

# Start the vLLM service with Docker Compose
echo "Starting vLLM server in Docker container..."
docker-compose up -d

# Wait for the service to start
echo "Waiting for vLLM server to start..."
sleep 5

# Check if the container is running
if docker-compose ps | grep -q "Up"; then
    CONTAINER_IP=$(hostname -I | awk '{print $1}')
    echo "vLLM server is running!"
    echo "Access the OpenAI-compatible API at: http://${CONTAINER_IP}:8142/v1"
    echo ""
    echo "Example usage:"
    echo "curl http://${CONTAINER_IP}:8142/v1/chat/completions \\"
    echo "  -H \"Content-Type: application/json\" \\"
    echo "  -d '{\"model\": \"facebook/opt-125m\", \"messages\": [{\"role\": \"user\", \"content\": \"Hello, how are you?\"}]}'"
    echo ""
    echo "To stop the server, run: docker-compose down"
else
    echo "Error: vLLM server failed to start."
    echo "Check container logs with: docker-compose logs"
fi