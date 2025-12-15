#!/bin/bash
set -e

CONF="/root/.config/rclone/rclone.conf"
if [ ! -f "$CONF" ]; then
  echo "❌ rclone config not found: $CONF"
  echo "👉 Upload rclone.conf to /workspace then run:"
  echo "   mkdir -p /root/.config/rclone && cp /workspace/rclone.conf $CONF && chmod 600 $CONF"
  exit 1
fi

BASE_DIR="/workspace/ComfyUI/models"
mkdir -p "$BASE_DIR"/{checkpoints,loras,vae,embeddings}

echo "🔄 Sync models from Google Drive..."
rclone copy kong_3d:models "$BASE_DIR" -P --transfers=4 --checkers=8 --checksum
echo "✅ Model sync complete"
