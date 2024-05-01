#!/bin/bash

# Define the aliases to add if missing
aliases=(
	alias prop='bash /home/adirksen/propagatie/propegatie.sh'
)

# Create a temporary file to store the modified .bashrc
temp_bashrc=$(mktemp)

# Copy .bashrc to the temporary file
cp ~/.bashrc "$temp_bashrc"

# Function to check if an alias exists in the temporary .bashrc
alias_exists() {
    grep -Fxq "$1" "$temp_bashrc"
}

# Function to add an alias to the temporary .bashrc if it doesn't exist
add_alias() {
    if ! alias_exists "$1"; then
        echo "$1" >> "$temp_bashrc"
        echo "Added: $1"
    fi
}

# Loop through each alias and add it if missing
for alias_cmd in "${aliases[@]}"; do
    add_alias "$alias_cmd"
done

# Overwrite the original .bashrc with the modified temporary file
cp "$temp_bashrc" ~/.bashrc

# Remove the temporary file
rm "$temp_bashrc"

# Source .bashrc to apply changes
source ~/.bashrc
