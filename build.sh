#!/bin/bash
set -euo pipefail

# Install necessary tools (idempotent; reruns safely)
sudo apt-get update -y
sudo apt-get install -y \
  bison \
  pkg-config \
  libpng-dev \
  g++ \
  make \
  gcc \
  git \
  curl

# Get RGBDS v1.0.1 (source tarball via GitHub tarball endpoint)
if [ -d "rgbds-src" ]; then
  rm -rf rgbds-src
fi
if [ -d "rgbds" ]; then
  rm -rf rgbds
fi

echo "Downloading RGBDS v1.0.1 source..."
curl -L -o rgbds.tar.gz https://github.com/gbdev/rgbds/tarball/v1.0.1  # :contentReference[oaicite:1]{index=1}
mkdir -p rgbds-src
tar -xzf rgbds.tar.gz -C rgbds-src --strip-components=1
rm rgbds.tar.gz

echo "Building and installing RGBDS locally..."
pushd rgbds-src
make clean
make
make install PREFIX="$(pwd)/../rgbds"
popd

# Build the ROM using the locally-installed tools
echo "Building pokecrystal..."
make clean
make RGBDS="$(pwd)/rgbds/bin/"

if [ ! -f "pokecrystal.gbc" ]; then
  echo "Build failed: pokecrystal.gbc not produced."
  exit 1
fi
