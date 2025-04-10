# vLLM Server with Remote GPU Setup

This setup allows running a vLLM server on a Linux machine while using GPUs from a Windows machine for the actual computation.

## How it Works

1. The Linux server runs the Ray head node and vLLM server
2. The Windows machine with GPU connects as a Ray worker node
3. vLLM distributes computation to the Windows GPU while the API server runs on Linux

## Requirements

### Linux Server
- Python 3.10+
- Ray
- vLLM

### Windows Machine
- Python 3.10+
- CUDA drivers installed
- Ray
- PyTorch with CUDA support

## Setup Instructions

### On Linux Server

1. Create virtual environment and install dependencies:
```bash
python -m venv vllm-env
source vllm-env/bin/activate
pip install vllm ray
```

2. Run the server script (update IP address before providing to Windows machine):
```bash
./start_vllm_server.sh
```

### On Windows Machine

1. Edit `windows_gpu_worker.bat` to set the correct HEAD_IP address of your Linux server
2. Run the Windows script as administrator
```
windows_gpu_worker.bat
```

## Configuration Options

You can modify both scripts to:
- Change the model used by vLLM
- Adjust tensor parallelism for multiple GPUs
- Change ports
- Set specific CUDA devices

## Troubleshooting

- Ensure both machines can reach each other on the network
- Check that the IP addresses and ports are correctly set
- Verify CUDA is properly installed on the Windows machine
- If connection fails, check Windows firewall settings