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
          "name": "Grace Hopper",
          "emoji": "\ud83e\uddea"
        }
      }
    ]
  },
  "channels": {
    "discord": {
      "enabled": true,
      "token": "${DISCORD_GRACE_TOKEN}",
      "groupPolicy": "allowlist",
      "guilds": {
        "1469116516619387085": {
          "channels": {
            "1470759711203786849": {
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
      "token": "grace-gateway-secret-2026"
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