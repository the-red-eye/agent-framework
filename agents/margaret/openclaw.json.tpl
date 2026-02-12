{
  "models": {
    "providers": {
      "deepseek": {
        "baseUrl": "https://api.deepseek.com/v1",
        "api": "openai-completions",
        "apiKey": "${DEEPSEEK_API_KEY}",
        "models": [
          {
            "id": "deepseek-chat",
            "name": "DeepSeek V3.2",
            "reasoning": true,
            "input": ["text"],
            "contextWindow": 163840,
            "maxTokens": 8192
          }
        ]
      }
    }
  },
  "agents": {
    "defaults": {
      "model": {
        "primary": "${MODEL}"
      },
      "workspace": "/workspace"
    },
    "list": [
      {
        "id": "main",
        "identity": {
          "name": "Margaret Hamilton",
          "emoji": "\ud83d\ude80"
        }
      }
    ]
  },
  "channels": {
    "discord": {
      "enabled": true,
      "token": "${DISCORD_MARGARET_TOKEN}",
      "groupPolicy": "allowlist",
      "guilds": {
        "1469116516619387085": {
          "channels": {
            "1470759724466180147": {
              "allow": true,
              "requireMention": false
            },
            "1469979522878144514": {
              "allow": true,
              "requireMention": true
            },
            "1469979526086787134": {
              "allow": true,
              "requireMention": true
            }
          }
        }
      },
      "allowBots": true
    }
  },
  "gateway": {
    "mode": "local",
    "auth": {
      "mode": "token",
      "token": "margaret-gateway-secret-2026"
    }
  },
  "plugins": {
    "entries": {
      "discord": {
        "enabled": true
      },
      "telegram": {
        "enabled": false
      }
    }
  }
}