FROM debian:bookworm-slim
ARG COPILOT_VERSION
ARG TARGETARCH
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates wget \
    && wget -q "https://github.com/github/copilot-cli/releases/download/v${COPILOT_VERSION}/copilot-linux-${TARGETARCH}.tar.gz" \
    && tar -xzf "copilot-linux-${TARGETARCH}.tar.gz" \
    && mv copilot /usr/local/bin/ \
    && rm "copilot-linux-${TARGETARCH}.tar.gz" \
    && apt-get purge -y wget && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["copilot", "--headless", "--host", "0.0.0.0", "--port", "4321"]
