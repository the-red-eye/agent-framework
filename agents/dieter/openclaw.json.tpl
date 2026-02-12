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
          "name": "Dieter Rams",
          "emoji": "\ud83c\udfa8"
        }
      }
    ]
  },
  "channels": {
    "discord": {
      "enabled": true,
      "token": "${DISCORD_DIETER_TOKEN}",
      "groupPolicy": "allowlist",
      "guilds": {
        "1469116516619387085": {
          "channels": {
            "1470759704052629643": {
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
      "token": "dieter-gateway-secret-2026"
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