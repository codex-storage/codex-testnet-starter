#!/bin/bash

source ./utils.sh

# Function to extract archive file using native tools
extract_archive() {
    local archive_file="$1"
    local extract_dir="$2"

    case "$OS" in
        linux|darwin)
            # Use tar for Linux and macOS (assuming .tar.gz file)
            tar -xzf "$archive_file" -C "$extract_dir"
            ;;
        windows)
            # Use unzip for Windows
            unzip -o "$archive_file" -d "$extract_dir"
            ;;
        *)
            echo "Unsupported OS for archive extraction"
            return 1
            ;;
    esac
}

# Function to download a file
download_file() {
    local url="$1"
    local output_file="$2"

    if command -v curl &> /dev/null; then
        curl -L -o "$output_file" "$url"
    elif command -v wget &> /dev/null; then
        wget -O "$output_file" "$url"
    else
        echo "Error: Neither curl nor wget is available. Please install one of them."
        return 1
    fi
}

# Set variables
OS=$(get_os)
ARCH=$(get_arch)
if [ "$OS" = "windows" ]; then
    ARCHIVE_EXT=".zip"
    EXE_EXT=".exe"
else
    ARCHIVE_EXT=".tar.gz"
    EXE_EXT=""
fi
VERSION="v0.1.3"
BASE_URL="https://github.com/codex-storage/nim-codex/releases/download/${VERSION}"
EXTRACT_DIR="./"
# Use BINARY_NAMES=("codex" "codex-prover") to also download/verify/extract prover binary
BINARY_NAMES=("codex")

# Download, verify, and extract each binary
for BINARY_NAME in "${BINARY_NAMES[@]}"; do
    FILE_NAME="${BINARY_NAME}-${VERSION}-${OS}-${ARCH}${ARCHIVE_EXT}"
    DOWNLOAD_URL="${BASE_URL}/${FILE_NAME}"
    CHECKSUM_URL="${BASE_URL}/${FILE_NAME}.sha256"

    # Download the binary file
    echo "Downloading ${FILE_NAME}..."
    if ! download_file "$DOWNLOAD_URL" "$FILE_NAME"; then
        echo "Download failed for ${FILE_NAME}"
        exit 1
    fi
    echo

    # Download the SHA256 checksum file
    echo "Downloading SHA256 checksum for ${FILE_NAME}..."
    if ! download_file "$CHECKSUM_URL" "${FILE_NAME}.sha256"; then
        echo "Checksum download failed for ${FILE_NAME}"
        exit 1
    fi
    echo

    # Verify the checksum
    echo "Verifying checksum for ${FILE_NAME}..."
    EXPECTED_SHA256=$(cat "${FILE_NAME}.sha256" | cut -d' ' -f1)
    if [ "$OS" = "darwin" ]; then
        ACTUAL_SHA256=$(shasum -a 256 "$FILE_NAME" | cut -d ' ' -f 1)
    else
        ACTUAL_SHA256=$(sha256sum "$FILE_NAME" | cut -d ' ' -f 1)
    fi

    if [ "$ACTUAL_SHA256" != "$EXPECTED_SHA256" ]; then
        echo "Checksum verification failed for ${FILE_NAME}. Expected: $EXPECTED_SHA256, Got: $ACTUAL_SHA256"
        exit 1
    fi
    echo

    # Extract the archive file
    echo "Extracting ${FILE_NAME}..."
    if ! extract_archive "$FILE_NAME" "$EXTRACT_DIR"; then
        echo "Extraction failed for ${FILE_NAME}"
        exit 1
    fi

    # Cleanup
    rm ${FILE_NAME}
    rm ${FILE_NAME}.sha256

    # Change permissions to add execution (skipped for Windows)
    FILE_NAME="${BINARY_NAME}-${VERSION}-${OS}-${ARCH}"
    echo "Changing permissions for ${FILE_NAME}..."
    BINARY_PATH="${EXTRACT_DIR}/${FILE_NAME}${EXE_EXT}"
    if [ -f "$BINARY_PATH" ]; then
        if ! change_permissions "$BINARY_PATH" +x; then
            echo "Changing permissions failed for $BINARY_PATH"
            exit 1
        fi
    else
        echo "Warning: Binary $BINARY_PATH not found"
    fi

done

echo "Setup completed successfully!"
