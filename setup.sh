#!/bin/bash

# Update package lists and install necessary packages
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    binutils \
    vim \
    clang \
    gdb \
    libcjson1 \
    libxml2 \
    libssl-dev \
    net-tools \
    curl \
    cmake \
    git \
    wget \
    python3 \
    python3-dev \
    python3-pip \
    libglib2.0-dev \
    libpixman-1-dev \
    ninja-build \
    psmisc

# Download and install OpenSSL 1.1.1f
mkdir -p ~/bughunt_src/
cd ~/bughunt_src/
if [ ! -f "/lib/x86_64-linux-gnu/libcrypto.so.1.1" ]; then
    wget https://www.openssl.org/source/old/1.1.1/openssl-1.1.1f.tar.gz
    tar xf openssl-1.1.1f.tar.gz
    rm openssl-1.1.1f.tar.gz
    cd openssl-1.1.1f/
    ./config
    make
    sudo ln -s $(pwd)/libcrypto.so.1.1 /lib/x86_64-linux-gnu/libcrypto.so.1.1
fi

# Avoid make install since this is an old package.
# sudo make install
cd ..

# Download AFLplusplus v4.20c and compile it
mkdir -p ~/bughunt_src/afl
cd ~/bughunt_src/afl
wget https://github.com/AFLplusplus/AFLplusplus/archive/refs/tags/v4.20c.tar.gz
tar -xzvf v4.20c.tar.gz
rm v4.20c.tar.gz
cd AFLplusplus-4.20c
make

# Install QEMU support for AFLplusplus
cd qemu_mode
./build_qemu_support.sh
cd ..

# Install AFLplusplus system-wide
sudo make install

# Install Python packages: lief and frida-tools
pip3 install --break-system-packages --no-cache-dir lief
pip3 install --break-system-packages --no-cache-dir frida-tools
