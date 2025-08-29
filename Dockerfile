FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl wget git vim jq sudo \
    python3 python3-pip \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN curl -fsSL https://claude.ai/install.sh | bash -s latest

ENV PATH="/root/.local/bin:${PATH}"

WORKDIR /workspace
CMD ["/bin/bash"]