#!/bin/bash

# Exit on any error
set -e

# Check for necessary tools
if ! command -v cmake &> /dev/null; then
    echo "CMake could not be found. Please install CMake."
    exit 1
fi

if ! command -v make &> /dev/null; then
    echo "Make could not be found. Please install Make."
    exit 1
fi

# Define directories
PROJECT_ROOT=$(pwd)
BUILD_DIR="$PROJECT_ROOT/build"
BENCHMARK_EXECUTABLE="$BUILD_DIR/benchmark_prover"

# Clean up any previous build artifacts
echo "Cleaning up previous build..."
rm -rf "$BUILD_DIR"

# Create build directory
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Configure the project using CMake
echo "Configuring the project with CMake..."
cmake ..

# Build the project
echo "Building the project..."
make

# Run the benchmark executable
if [ -f "$BENCHMARK_EXECUTABLE" ]; then
    echo "Running benchmarks..."
    ./"$BENCHMARK_EXECUTABLE"
else
    echo "Benchmark executable not found. Please check your CMakeLists.txt and ensure it creates the benchmark executable."
    exit 1
fi

# Go back to the project root directory
cd "$PROJECT_ROOT"

echo "Benchmarking completed!"
