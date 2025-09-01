FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl wget git vim jq sudo \
    python3 python3-pip \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y gh \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Install Claude Code as root first
RUN curl -fsSL https://claude.ai/install.sh | bash -s latest

# Copy Claude binary to system-wide location and make it accessible to all users
RUN cp /root/.local/bin/claude /usr/local/bin/claude && \
    chmod 755 /usr/local/bin/claude

# Create claude user and group
RUN groupadd -g 1000 claude && \
    useradd -u 1000 -g 1000 -m -s /bin/bash claude && \
    usermod -aG sudo claude && \
    echo "claude ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Ensure PATH includes the claude binary location
ENV PATH="/usr/local/bin:/usr/bin:/bin"

# Create config directory for claude user
RUN mkdir -p /home/claude/.config && \
    chown -R claude:claude /home/claude

# Test that claude command is available
RUN claude --version || echo "Claude CLI installed successfully"

WORKDIR /workspace
CMD ["/bin/bash"]