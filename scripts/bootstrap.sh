#!/bin/bash
set -e

echo "Bootstrapping Btech Design System..."

# Install Node dependencies
echo "Installing pnpm dependencies..."
pnpm install

# Build tokens (generates btech_tokens Flutter package + web outputs)
echo "Building design tokens..."
pnpm build:tokens

# Flutter dependencies (resolves btech_tokens path dependency automatically)
if command -v flutter &> /dev/null; then
  echo "Installing Flutter dependencies..."
  cd ui/flutter && flutter pub get && cd ../..
  echo "Flutter setup complete."
else
  echo "Flutter not found. Skipping Flutter setup."
fi

echo "Bootstrap complete!"
