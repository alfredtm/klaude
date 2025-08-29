# Klaude - Claude Code in Docker (YOLO Mode)

Run Claude Code in a containerized environment with full access to your project directory. Perfect for when you want Claude to have complete control over your codebase without worrying about system-wide changes.

## Installation

### Using Homebrew (Recommended)

```bash
# Add the tap
brew tap alfredtm/klaude

# Install klaude
brew install klaude
```

### Manual Installation

Clone this repository and run the install script manually if you prefer not to use Homebrew.

## Prerequisites

- Docker Desktop installed and running
- Claude Pro or Claude Max subscription
- macOS or Linux (with Docker installed)

## Usage

### Basic Commands

```bash
# Start Klaude in current directory
klaude

# Start Klaude in specific directory
klaude /path/to/project

# Update to latest Claude Code version
klaude-update

# Remove all Klaude data and containers
klaude-nuke

# Clear saved authentication
klaude-auth-reset
```

## How It Works

1. **First Run**: Pulls a pre-built Docker image from GitHub Container Registry (ghcr.io/alfredtm/klaude)
2. **Authentication**: On first use, Claude will open a browser for login (credentials are saved for future sessions)
3. **Container**: Runs Claude Code in an isolated Docker container with your project mounted
4. **YOLO Mode**: Claude has full read/write access to the mounted directory

## Important Notes

⚠️ **YOLO Mode Warning**: Claude has FULL access to the mounted directory. Changes are made to your ACTUAL files, not copies. Use version control!

⚠️ **Security**: Only run in directories where you're comfortable with Claude having complete control.

## Features

- 🚀 Quick setup - no local Claude installation needed
- 🔒 Isolated environment - Claude runs in Docker
- 💾 Persistent authentication between sessions
- 🔄 Easy updates with `klaude-update`
- 🗑️ Clean removal with `klaude-nuke`
- 🏗️ Multi-platform Docker images (Intel & ARM64)

## Development

This repository serves as both:
1. A Homebrew tap (Formula directory contains the brew formula)
2. The source for the Docker image (Dockerfile in root)

GitHub Actions automatically builds and publishes Docker images to GitHub Container Registry on every push to main.

## License

MIT
