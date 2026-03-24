#!/bin/bash
# Simple static file server for Clawbert
# Serves on port 3000, accessible via Tailscale

PORT=3000
DIR="/home/aipi/.openclaw/workspace/clawbert"

# Check if port is in use
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "Clawbert already running on port $PORT"
    echo "Access at: http://localhost:$PORT"
    exit 0
fi

cd "$DIR"

# Use Python's simple HTTP server (available on Pi)
nohup python3 -m http.server $PORT > /tmp/clawbert.log 2>&1 &

echo "Clawbert started on port $PORT"
echo "Access locally: http://localhost:$PORT"
echo "Access via Tailscale: http://$(tailscale ip -4):$PORT"
