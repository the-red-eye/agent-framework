# 🏗️ Agent Framework

A declarative framework for managing multi-agent AI teams with OpenClaw.

## Overview

```
┌────────────────────────────────────────────────┐
│              CONTROL PLANE                     │
│  framework.yaml  models.yaml  roles.yaml      │
│  teams/*.yaml                                  │
└────────────────────────────────────────────────┘
                     │
          HAL reads configs, spawns teams
                     │
┌────────────────────┼───────────────────────────┐
│              DATA PLANE                        │
│   ┌─────────┐  ┌─────────┐  ┌─────────┐      │
│   │ Team A  │  │ Team B  │  │ Team C  │      │
│   │   PM ───┼──┼─ Devs   │  │   ...   │      │
│   └─────────┘  └─────────┘  └─────────┘      │
└────────────────────────────────────────────────┘
```

## Features

- **Declarative** — Define teams in YAML, framework handles the rest
- **Multi-team** — Run multiple isolated teams simultaneously
- **Flexible** — Swap models, add/remove agents on the fly
- **Observable** — All communication via Discord, humans can watch/intervene
- **Cost-aware** — Use different models for different roles

## Quick Start

```bash
# 1. Configure your team
cp config/teams/_template.yaml config/teams/my-project.yaml
vim config/teams/my-project.yaml

# 2. Start the team
./scripts/team-up.sh my-project

# 3. Check status
./scripts/team-status.sh my-project

# 4. Stop when done
./scripts/team-down.sh my-project
```

## Structure

```
agent-framework/
├── config/
│   ├── framework.yaml      # Global settings
│   ├── models.yaml         # Available models & costs
│   ├── roles.yaml          # Role templates (PM, Dev, QA...)
│   └── teams/              # Team definitions
│       └── adamastor.yaml
├── agents/
│   ├── _templates/         # SOUL.md templates per role
│   └── pool/               # Individual agent identities
├── scripts/                # Operations scripts
├── teams/                  # Runtime state (gitignored)
└── docker-compose.yaml     # Container orchestration
```

## Configuration

### Define a Team

```yaml
# config/teams/my-project.yaml
team:
  id: my-project
  name: "My Project Team"
  status: active

project:
  repo: "user/my-project"
  
roster:
  pm:
    agent: ada
    model: gemini-pro
  members:
    - agent: linus
      role: dev-lead
      model: deepseek
    - agent: grace
      role: qa
      model: gemini-flash
```

### Available Models

| Alias | Provider | Best For | Cost |
|-------|----------|----------|------|
| opus | Anthropic | Complex reasoning | $$$ |
| sonnet | Anthropic | Balanced tasks | $$ |
| gemini-pro | Google | PM, coordination | $ |
| gemini-flash | Google | Quick tasks | ¢ |
| deepseek | DeepSeek | Coding | ¢ |

## Operations

| Command | Description |
|---------|-------------|
| `./scripts/team-up.sh <team>` | Start a team |
| `./scripts/team-down.sh <team>` | Stop a team |
| `./scripts/team-status.sh <team>` | Check team status |
| `./scripts/agent-swap.sh <team> <agent> --model <model>` | Change agent model |
| `./scripts/apply-config.sh` | Apply config changes |

## Requirements

- [OpenClaw](https://github.com/openclaw/openclaw) installed
- Discord server with bot tokens
- API keys for desired providers

## License

MIT
