#!/bin/bash

# List of packages to globally activate
packages=(
  "fvm"
  # Add more packages as needed
)

# Loop through the packages and activate each one
for package in "${packages[@]}"; do
  dart pub global activate "$package"
done