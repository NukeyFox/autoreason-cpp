# Use Debian as the base image
FROM debian:bullseye

# Install system dependencies and tools
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    gdb \
    git \
    vim \
    curl \
    sudo \
    libssl-dev \
    python3 \
    python3-pip \  
    llvm \         
    clang         

# Install Google Test (gtest) dependencies
RUN apt-get install -y libgtest-dev

# Build gtest from source
RUN cd /usr/src/gtest && \
    cmake . && \
    make && \
    cp lib/*.a /usr/lib

# Install Valgrind
RUN apt-get install -y valgrind

# Create a non-root user with sudo access
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set the default user to non-root user
USER $USERNAME
