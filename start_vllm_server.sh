#!/bin/bash
# start_vllm_server.sh - Script for the Linux server (head node)
# This script starts Ray head node and vLLM server without using local resources for LLM inference

# Configuration parameters
PORT=6379
MODEL="facebook/opt-125m"  # Default small model, change to your preferred model
SERVER_PORT=8142          # Port for vLLM API server (must be above 1024 for non-root)

# Stop any existing Ray processes
echo "Stopping existing Ray processes..."
ray stop

# Start Ray head node - Allow 2 CPUs for coordination but don't use for model computation
echo "Starting Ray head node on port $PORT..."
ray start --head --port=$PORT --num-cpus=2 --num-gpus=0

# Wait for worker node(s) to connect
echo "Waiting for worker node(s) with GPU to connect..."
echo "On your Windows GPU machine, run the provided worker script to connect to $(hostname -I | awk '{print $1}'):$PORT"
echo "Press Enter once worker node is connected to continue..."
read

# Activate the virtual environment
source vllm-env/bin/activate

# Check Ray cluster status
echo "Checking Ray cluster status..."
ray status

# Start vLLM server
echo "Starting vLLM server with model: $MODEL"
python -m vllm.entrypoints.openai.api_server \
    --model $MODEL \
    --host 0.0.0.0 \
    --port $SERVER_PORT \
    --device cpu

echo "vLLM server running at http://$(hostname -I | awk '{print $1}'):$SERVER_PORT"
echo "Press Ctrl+C to stop the server"