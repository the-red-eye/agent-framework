## Stage 1 — build: install openclaw via bun
FROM oven/bun:1-slim AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl ca-certificates python3 make g++ \
    && rm -rf /var/lib/apt/lists/*

RUN bun install -g openclaw

# Remove build artifacts not needed at runtime
RUN rm -rf \
    /root/.bun/install/global/node_modules/@node-llama-cpp \
    /root/.bun/install/global/node_modules/node-llama-cpp/bins \
    /root/.bun/install/global/node_modules/node-llama-cpp/llama

## Stage 2 — runtime: power tools for Linus & Ada
FROM oven/bun:1-slim

# Install essentials + Dev tools (Python, GCC, Doppler, GH CLI) + Browser deps (Playwright)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git curl jq ca-certificates gnupg apt-transport-https \
    python3 python3-pip make g++ \
    vim nano iputils-ping \
    # Chromium deps for browser tool
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 libgbm1 libasound2 \
    && curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends doppler gh \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright browser (Chromium only to save space, good enough for vision)
RUN bun install -g playwright && bunx playwright install chromium --with-deps

# Copy bun global install from build stage
COPY --from=build /root/.bun /root/.bun
ENV PATH="/root/.bun/bin:$PATH"

RUN mkdir -p /workspace /config /shared /projects
WORKDIR /workspace

CMD ["bun", "/root/.bun/install/global/node_modules/openclaw/openclaw.mjs", "gateway", "--port", "18789", "--verbose"]
