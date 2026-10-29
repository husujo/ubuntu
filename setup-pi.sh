#!/bin/bash

# usage 
# curl -fsSL "https://raw.githubusercontent.com/husujo/ubuntu/main/setup-pi.sh?v=1" | bash

if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq not found" >&2
    exit 1
fi

mkdir -p ~/.pi/agent

if [[ ! -f ~/.pi/agent/settings.json ]]; then
    cat > ~/.pi/agent/settings.json <<'JSON'
{
  "defaultTools": ["read", "grep", "find", "ls"],
  "prompts": ["~/.agents/prompts"],
  "skills": ["!skills/synced/**"]
}
JSON
fi

if [[ ! -f ~/.pi/agent/keybindings.json ]]; then
    cat > ~/.pi/agent/keybindings.json <<'JSON'
{
  "tui.editor.deleteWordBackward": ["ctrl+w", "alt+backspace", "ctrl+backspace", "ctrl+h"],
  "tui.input.newLine": ["shift+enter", "ctrl+j", "alt+enter"],
  "app.message.followUp": ["ctrl+alt+enter"]
}
JSON
fi

# TODO handle OLLAMA_HOST env for baseurl
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
          "id": "deepseek-flash",
          "name": "DeepSeek V4.1 Flash",
          "contextWindow": 1000000,
          "maxTokens": 384000,
          "input": [
            "text",
            "image"
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

# Discover installed Ollama models and update only the Ollama provider.
if command -v ollama >/dev/null 2>&1; then
  file=~/.pi/agent/models.json
  host="${OLLAMA_HOST:-127.0.0.1:11434}"
  [[ $host != http* ]] && host="http://$host"

  models="$(
    for id in $(ollama ls | awk 'NR > 1 {print $1}'); do
      ollama show "$id" </dev/null 2>/dev/null |
        jq -Rn --arg id "$id" '{id: $id, contextWindow: 65536, reasoning: any(inputs; test("^\\s+thinking\\s*$"))}'
    done | jq -s .
  )"

  if [[ $models != '[]' ]]; then
    jq --argjson models "$models" --arg url "${host%/}/v1" \
      '.providers.ollama |= (.baseUrl = $url | .models = $models)' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
  fi
fi

# download pi
if ! command -v pi >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -fsSL https://pi.dev/install.sh | sh
fi




