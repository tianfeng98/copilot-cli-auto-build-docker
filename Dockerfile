FROM debian:bookworm-slim
ARG COPILOT_VERSION
ARG TARGETARCH
RUN echo "=== Build Stage Variables ===" \
    && echo "COPILOT_VERSION: $COPILOT_VERSION" \
    && echo "TARGETARCH: $TARGETARCH"
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates wget \
    && COPILOT_ARCH="${TARGETARCH}" \
    && [ "${TARGETARCH}" != "amd64" ] || COPILOT_ARCH="x64" \
    && wget -q "https://github.com/github/copilot-cli/releases/download/v${COPILOT_VERSION}/copilot-linux-${COPILOT_ARCH}.tar.gz" \
    && tar -xzf "copilot-linux-${COPILOT_ARCH}.tar.gz" \
    && mv copilot /usr/local/bin/ \
    && rm "copilot-linux-${COPILOT_ARCH}.tar.gz" \
    && apt-get purge -y wget && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["copilot", "--headless", "--host", "0.0.0.0", "--port", "4321"]
