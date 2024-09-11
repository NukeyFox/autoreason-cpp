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

if ! command -v valgrind &> /dev/null; then
    echo "Valgrind could not be found. Please install Valgrind."
    exit 1
fi

if ! command -v callgrind_annotate &> /dev/null; then
    echo "Callgrind annotate tool could not be found. Please install KCacheGrind or Valgrind tools."
    exit 1
fi

# Define directories
PROJECT_ROOT=$(pwd)
BUILD_DIR="$PROJECT_ROOT/build/profile"
TEST_EXECUTABLE="$BUILD_DIR/prover_test"

# Clean up any previous build artifacts
echo "Cleaning up previous build..."
rm -rf "$BUILD_DIR"

# Create build directory
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Configure the project using CMake with Profile configuration
echo "Configuring the project with CMake for profiling..."
cmake -DCMAKE_BUILD_TYPE=Profile ../..

# Build the project
echo "Building the project..."
make

# Run the test executable under Valgrind Callgrind
if [ -f "$TEST_EXECUTABLE" ]; then
    echo "Running tests with Valgrind Callgrind..."
    valgrind --tool=callgrind --callgrind-out-file=callgrind.out "$TEST_EXECUTABLE"
else
    echo "Test executable not found. Please check your CMakeLists.txt and ensure it creates the test executable."
    exit 1
fi

# Analyze the profiling data
echo "Analyzing profiling data with callgrind_annotate..."
callgrind_annotate callgrind.out > callgrind_analysis.txt

# Check if KCacheGrind is installed for visual analysis
if command -v kcachegrind &> /dev/null; then
    echo "Opening KCacheGrind for visual analysis..."
    kcachegrind callgrind.out &
else
    echo "KCacheGrind is not installed. You can install it for visual analysis of the profiling data."
fi

# Go back to the project root directory
cd "$PROJECT_ROOT"

echo "Profiling completed! Results saved in callgrind_analysis.txt"
