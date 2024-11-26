#!/bin/bash

# Variables
NETWORK="${NETWORK:-testnet}"
VERSION="${VERSION:-v0.1.9}"
LOG_LEVEL="${LOG_LEVEL:-info}"
DOWNLOAD="${DOWNLOAD}"

# Function to detect OS
get_os() {
  case "$(uname -s)" in
    Linux*)                      echo "linux"   ;;
    Darwin*)                     echo "darwin"  ;;
    CYGWIN*|MINGW*|MSYS*|MINGW*) echo "windows" ;;
    *)                           echo "unknown" ;;
  esac
}

# Function to detect CPU architecture
get_arch() {
  case "$(uname -m)" in
    x86_64|amd64)  echo "amd64"                                         ;;
    arm64|aarch64) echo "arm64"                                         ;;
    *)             echo "Unsupported architecture: $(uname -m)"; exit 1 ;;
  esac
}

# Function to change file permissions using native OS commands
change_permissions() {
  local file_path="$1"
  local permissions="$2"

  case "$OS" in
    linux|darwin) chmod $permissions "$file_path"                             ;;
    windows)      echo "Skipping permission change on Windows for $file_path" ;;
    *)            echo "Unsupported OS for changing permissions"; return 1    ;;
  esac
}

# Function to get IP on Linux and macOS
get_ip_unix() {
  if command -v ip >/dev/null 2>&1; then
    ip addr show | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | cut -d "/" -f 1 | head -n 1
  elif command -v ifconfig >/dev/null 2>&1; then
    ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -n 1
  else
    echo "Unable to find IP address. Neither 'ip' nor 'ifconfig' command found."
    exit 1
  fi
}

# Function to get IP on Windows
get_ip_windows() {
  ipconfig | grep -i "IPv4 Address" | awk '{print $NF}' | head -n 1
}

# Function to get Public IP using ip lookup service
get_ip_public() {
  curl -m 5 -s https://ip.codex.storage
}

# Detect the operating system and call the appropriate function
get_ip() {
  case "$(uname -s)" in
    Linux*|Darwin*)                echo $(get_ip_unix)                         ;;
    CYGWIN*|MINGW32*|MSYS*|MINGW*) echo $(get_ip_windows)                      ;;
    *)                             echo "Unsupported operating system"; exit 1 ;;
    esac
}
