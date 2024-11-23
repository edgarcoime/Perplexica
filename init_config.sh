#!/bin/bash

# # Define the log file path
# LOG_FILE="/var/log/init.log"
#
# # Redirect all output to the log file
# exec > "$LOG_FILE" 2>&1

# Define the path to the configuration file
SAMPLE_CONFIG="sample.config.toml"
CONFIG_FILE="config.toml"

# Check if the sample config file exists
if [ ! -f "$SAMPLE_CONFIG" ]; then
    echo "Error: $SAMPLE_CONFIG not found."
    exit 1
fi

# # Copy sample.config.toml to config.toml
cp "$SAMPLE_CONFIG" "$CONFIG_FILE"
echo "Copied $SAMPLE_CONFIG to $CONFIG_FILE."

echo "openai: ${OPENAI:-}"
echo "groq: ${GROQ:-}"
echo "anth: ${ANTHROPIC:-}"

# Detect the operating system
OS=$(uname)

# Use different sed options based on OS
if [ "$OS" == "Darwin" ]; then
    # macOS sed command
    sed -i '' "s|OPENAI = .*|OPENAI = \"${OPENAI:-}\"|g" "$CONFIG_FILE"
    sed -i '' "s|GROQ = .*|GROQ = \"${GROQ:-}\"|g" "$CONFIG_FILE"
    sed -i '' "s|ANTHROPIC = .*|ANTHROPIC = \"${ANTHROPIC:-}\"|g" "$CONFIG_FILE"
else
    # Linux sed command
    sed -i "s|OPENAI = .*|OPENAI = \"${OPENAI:-}\"|g" "$CONFIG_FILE"
    sed -i "s|GROQ = .*|GROQ = \"${GROQ:-}\"|g" "$CONFIG_FILE"
    sed -i "s|ANTHROPIC = .*|ANTHROPIC = \"${ANTHROPIC:-}\"|g" "$CONFIG_FILE"
fi

echo "Populated $CONFIG_FILE with API keys (or defaults)."

# Then run the CMD
exec "$@"
