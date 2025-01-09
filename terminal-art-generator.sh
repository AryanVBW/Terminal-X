#!/bin/bash

# Colors
CYAN="\033[96m"
PURPLE="\033[95m"
YELLOW="\033[93m"
RESET="\033[0m"

# Function to generate ASCII art using figlet
generate_ascii_art() {
    local text="$1"
    which figlet > /dev/null 2>&1 || {
        echo "Installing figlet..."
        brew install figlet
    }
    figlet -f standard "$text"
}

# Function to create frame
create_frame() {
    local width=75
    echo -e "${CYAN}+$(printf '=%.0s' $(seq 1 $width))+${RESET}"
}

# Get user details
read -p "Enter your name: " USER_NAME
read -p "Enter your GitHub username: " GITHUB_USER
read -p "Enter your website: " WEBSITE
read -p "Enter your Instagram handle: " INSTAGRAM
read -p "Enter your email: " EMAIL

# Create the output file
OUTPUT_FILE="$HOME/.terminal-welcome"

{
    echo "#!/bin/bash"
    echo ""
    echo "# Terminal Welcome Script"
    echo "clear"
    
    # Frame start
    echo "echo -e \"${CYAN}+$(printf '=%.0s' $(seq 1 75))+${RESET}\""
    
    # ASCII Art
    echo "echo -e \"${CYAN}\""
    generate_ascii_art "$USER_NAME" | while read -r line; do
        echo "echo -e \"$line\""
    done
    echo "echo -e \"${RESET}\""
    
    # User details
    echo "echo -e \"🔥${PURPLE}GitHub:     ${RESET}github.com/$GITHUB_USER\""
    echo "echo -e \"🌐${PURPLE}Site:       ${RESET}$WEBSITE\""
    echo "echo -e \"💝${PURPLE}Instagram:  ${RESET}$INSTAGRAM\""
    echo "echo -e \"📧${PURPLE}Email:      ${RESET}$EMAIL\""
    
    # Frame end
    echo "echo -e \"${CYAN}+$(printf '=%.0s' $(seq 1 75))+${RESET}\""
    echo "echo -e \"${YELLOW}Welcome to $USER_NAME's Coding World!${RESET}\""
    echo ""
} > "$OUTPUT_FILE"

# Make the file executable
chmod +x "$OUTPUT_FILE"

# Add to shell rc file
RC_FILE="$HOME/.zshrc"
if [ -f "$HOME/.bashrc" ]; then
    RC_FILE="$HOME/.bashrc"
fi

# Check if welcome script is already in rc file
if ! grep -q "$OUTPUT_FILE" "$RC_FILE"; then
    echo "" >> "$RC_FILE"
    echo "# Terminal Welcome Message" >> "$RC_FILE"
    echo "$OUTPUT_FILE" >> "$RC_FILE"
fi

echo "Setup complete! Your custom terminal art has been created."
echo "Please restart your terminal to see the changes."
