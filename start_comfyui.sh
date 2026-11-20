#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MODEL_DIR="/srv/models/comfyui"
OUTPUT_DIR="/srv/models/outputs_comfy"
PORT=9820

if [[ $# -gt 0 && "$1" != -* ]]; then
    PORT="$1"
    shift
fi

cd "$SCRIPT_DIR"

if [[ ! -x "$SCRIPT_DIR/.venv/bin/python" ]]; then
    echo "ComfyUIの仮想環境が見つかりません: $SCRIPT_DIR/.venv" >&2
    echo "先に .venv を作成してください。" >&2
    exit 1
fi

source "$SCRIPT_DIR/.venv/bin/activate"
exec python main.py \
    --enable-manager \
    --models-directory "$MODEL_DIR" \
    --output-directory "$OUTPUT_DIR" \
    --use-sage-attention \
    --extra-model-paths-config "$SCRIPT_DIR/extra_model_paths.yaml" \
    --listen 0.0.0.0 \
    --port "$PORT" \
    "$@"
