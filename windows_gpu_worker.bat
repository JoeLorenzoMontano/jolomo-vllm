@echo off
:: windows_gpu_worker.bat - Script for Windows machine with GPU
:: This script connects to the Ray head node and provides GPU resources

:: Configuration - EDIT THIS SECTION
set HEAD_IP=192.168.1.40
set HEAD_PORT=6379
set GPU_COUNT=1
set VENV_NAME=vllm-env

:: Create and activate virtual environment if it doesn't exist
if not exist %VENV_NAME%\Scripts\activate.bat (
    echo Creating virtual environment: %VENV_NAME%
    python -m venv %VENV_NAME%
    call %VENV_NAME%\Scripts\activate.bat
    echo Installing required packages...
    pip install ray torch
) else (
    call %VENV_NAME%\Scripts\activate.bat
)

echo Starting Ray worker node with %GPU_COUNT% GPU(s)...
echo Connecting to head node at %HEAD_IP%:%HEAD_PORT%

:: Start Ray worker with GPU resources
:: The --num-cpus=0 ensures only GPU resources are used
ray start --address=%HEAD_IP%:%HEAD_PORT% --num-gpus=%GPU_COUNT% --resources={"worker_resources": 1}

echo Worker node started and connected to head node
echo This worker is now providing GPU resources to the vLLM server
echo Keep this window open to maintain the connection
echo Press Ctrl+C to disconnect

:: Keep the script running
:loop
timeout /t 60 > NUL
goto loop