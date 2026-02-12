{
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
          "name": "Ada Lovelace",
          "emoji": "📋"
        }
      }
    ]
  },
  "channels": {
    "discord": {
      "enabled": true,
      "token": "${DISCORD_ADA_TOKEN}",
      "groupPolicy": "allowlist",
      "guilds": {
        "1469116516619387085": {
          "channels": {
            "1470759666559488021": {
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
            },
            "1469979524350607361": {
              "allow": true,
              "requireMention": false
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
      "token": "ada-gateway-secret-2026"
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
