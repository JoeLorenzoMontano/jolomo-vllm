# vLLM Server Setup

This repository contains scripts for setting up a vLLM server, either in a distributed configuration or using Docker.

## Docker-Based Setup (Recommended)

The easiest way to run vLLM is using Docker:

1. Make sure Docker and Docker Compose are installed on your system
2. Run the start script:
   ```bash
   ./start_vllm_docker.sh
   ```
3. The vLLM server will be accessible at http://YOUR_IP:8142/v1

This method runs vLLM on your CPU and doesn't require a GPU.

### Customizing the Docker Setup

To customize the model or other parameters, edit the `docker-compose.yml` file:

```yaml
environment:
  - MODEL=facebook/opt-125m  # Change this to any HuggingFace model
  - DEVICE=cpu               # Keep as CPU for this machine
```

## Distributed Setup with Windows GPU

Alternatively, you can run vLLM in a distributed setup where:
- This Linux server hosts the API endpoint
- A Windows GPU machine provides GPU resources for inference

### Linux Server Setup

1. Start the Ray head node and API server:
   ```bash
   ./start_vllm_server.sh
   ```

### Windows GPU Machine Setup

1. Edit `windows_gpu_worker.bat` to set the correct Linux server IP
2. Run the script as administrator on the Windows machine
3. Once connected, press Enter on the Linux server to continue

## Technical Details

- vLLM provides a high-performance model serving system optimized for LLMs
- Ray provides the framework for distributed computing
- The Docker setup avoids platform compatibility issues

## Troubleshooting

If you encounter issues with the distributed setup, try the Docker-based approach instead, as it's more reliable on CPU-only machines.