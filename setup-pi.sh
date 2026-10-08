#!/bin/bash

# usage 
# curl -fsSL "https://raw.githubusercontent.com/husujo/ubuntu/main/setup-pi.sh?v=1" | bash

if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq not found" >&2
    exit 1
fi

mkdir -p ~/.pi/agent

if [[ ! -f ~/.pi/agent/AGENTS.md ]]; then
    curl -fsSLo ~/.pi/agent/AGENTS.md "https://raw.githubusercontent.com/husujo/ubuntu/main/AGENTS.md?v=1"
fi

if [[ ! -f ~/.pi/agent/settings.json ]]; then
    cat > ~/.pi/agent/settings.json <<'JSON'
{
  "defaultTools": ["read", "grep", "find", "ls"]
}
JSON
fi

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
if command -v ollama >/dev/null 2>&1; then
    models="$(
        ollama ls |
        awk 'NR > 1 {print $1}' |
        jq -Rn '[inputs | {id: ., contextWindow: 65536}]'
    )"

    if jq -e 'length > 0' <<< "$models" >/dev/null; then
        jq --argjson models "$models" \
            '.providers.ollama.models = $models' \
            ~/.pi/agent/models.json > /tmp/models.json &&
        mv /tmp/models.json ~/.pi/agent/models.json
    fi
fi

# download pi
if ! command -v pi >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -fsSL https://pi.dev/install.sh | sh
fi




