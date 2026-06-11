FROM debian:12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://opencode.ai/install | bash \
    && cp /root/.opencode/bin/opencode /usr/local/bin/opencode \
    && chmod 755 /usr/local/bin/opencode

ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} opencode \
    && useradd -m -u ${UID} -g ${GID} -s /bin/bash opencode \
    && mkdir -p /workspace /home/opencode/.config/opencode /home/opencode/.local/share/opencode \
    && chown -R opencode:opencode /workspace /home/opencode

USER opencode

ENV HOME="/home/opencode" \
    XDG_CONFIG_HOME="/home/opencode/.config" \
    XDG_DATA_HOME="/home/opencode/.local/share"

VOLUME /workspace
WORKDIR /workspace

CMD ["opencode"]
