#!/bin/bash

mkdir -p ~/.pi/agent

curl -sLo ~/.pi/agent/AGENTS.md "https://raw.githubusercontent.com/husujo/ubuntu/main/AGENTS.md?v=1"

echo '{
  "defaultTools": ["read", "grep", "find", "ls"]
}' > ~/.pi/agent/settings.json

# Create models.json with provider stubs if it doesn't exist.
if [[ ! -f ~/.pi/agent/models.json ]]; then
    cat > ~/.pi/agent/models.json <<'JSON'
{
  "providers": {
    "ollama": {
      "baseUrl": "http://localhost:11434/v1",
      "api": "openai-completions",
      "apiKey": "ollama",
      "models": []
    },
    "deepseek": {
      "baseUrl": "https://api.deepseek.com",
      "api": "openai-completions",
      "apiKey": "$DEEPSEEK_API_KEY",
      "models": [
        {
          "id": "deepseek-v4-pro",
          "name": "DeepSeek V4 Pro",
          "contextWindow": 1000000,
          "maxTokens": 384000,
          "input": [
            "text"
          ],
          "reasoning": true,
          "cost": {
            "input": 1.74,
            "output": 3.48,
            "cacheRead": 0.145,
            "cacheWrite": 0
          }
        },
        {
          "id": "deepseek-v4-flash",
          "name": "DeepSeek V4 Flash",
          "contextWindow": 1000000,
          "maxTokens": 384000,
          "input": [
            "text"
          ],
          "reasoning": true,
          "cost": {
            "input": 0.14,
            "output": 0.28,
            "cacheRead": 0.028,
            "cacheWrite": 0
          }
        }
      ]
    }
  }
}
JSON
fi

# Discover installed Ollama models and update only the Ollama model list.
# TODO only do this if ollama command exists on system
models="$(
    ollama ls |
    awk 'NR > 1 {print $1}' |
    jq -Rn '[inputs | {id: ., contextWindow: 65536}]'
)"

jq --argjson models "$models" \
    '.providers.ollama.models = $models' \
    ~/.pi/agent/models.json > /tmp/models.json &&
mv /tmp/models.json ~/.pi/agent/models.json




curl --proto '=https' --tlsv1.2 -fsSL https://pi.dev/install.sh | sh
