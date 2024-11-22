#!/bin/bash

# Define the path to the configuration file
SAMPLE_CONFIG="sample.config.toml"
CONFIG_FILE="config.toml"

# Check if the sample config file exists
if [ ! -f "$SAMPLE_CONFIG" ]; then
    echo "Error: $SAMPLE_CONFIG not found."
    exit 1
fi

# Copy sample.config.toml to config.toml
cp "$SAMPLE_CONFIG" "$CONFIG_FILE"
echo "Copied $SAMPLE_CONFIG to $CONFIG_FILE."

# Populate the config.toml file with environment variables or default to empty strings
sed -i '' "s|OPENAI = .*|OPENAI = \"${OPENAI:-}\"|g" "$CONFIG_FILE"
sed -i '' "s|GROQ = .*|GROQ = \"${GROQ:-}\"|g" "$CONFIG_FILE"
sed -i '' "s|ANTHROPIC = .*|ANTHROPIC = \"${ANTHROPIC:-}\"|g" "$CONFIG_FILE"

echo "Populated $CONFIG_FILE with API keys (or defaults)."
