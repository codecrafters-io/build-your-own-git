#!/usr/bin/env sh

set -e # Exit on failure
echo "Downloading babashka"
curl -L -o babashka.tar.gz https://github.com/babashka/babashka/releases/download/v1.12.200/babashka-1.12.200-linux-amd64-static.tar.gz

echo "Unpacking babashka"
tar -xzf babashka.tar.gz

echo "Installing babashka"
mv bb /usr/local/bin/
chmod +x /usr/local/bin/bb

echo "Cleaning up"
rm babashka.tar.gz

echo "babashka installed successfully!"
