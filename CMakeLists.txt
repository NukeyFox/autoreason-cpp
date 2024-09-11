cmake_minimum_required(VERSION 3.10)
project(autoreason)

set(CMAKE_CXX_STANDARD 17)

# Include directories
include_directories(include)

# Define custom build types
set(CMAKE_CONFIGURATION_TYPES "Debug;Release;Profile" CACHE STRING "" FORCE)

# Profiling build type
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)  # Default build type
endif()

# Set compiler flags for different build types
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    message("Building in Debug mode")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O0")
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    message("Building in Release mode")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3")
elseif(CMAKE_BUILD_TYPE STREQUAL "Profile")
    message("Building in Profiling mode (Valgrind)")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g -O2")  # Optimization and debugging symbols
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -g")
endif()

# Add Google Test and Benchmark using FetchContent
include(FetchContent)
FetchContent_Declare(
  gtest
  URL https://github.com/google/googletest/archive/refs/tags/release-1.11.0.zip
)
FetchContent_Declare(
  benchmark
  URL https://github.com/google/benchmark/archive/refs/tags/v1.7.1.zip
)
FetchContent_MakeAvailable(gtest benchmark)

# Link benchmark with pthread
find_package(Threads REQUIRED)
set(BENCHMARK_ENABLE_TESTING OFF)
add_library(benchmark::benchmark ALIAS benchmark)

# Library target
add_library(autoreason src/prover.cpp)

# Test executable
enable_testing()
add_executable(prover_test tests/prover_test.cpp)
target_link_libraries(prover_test autoreason gtest_main)

# Benchmark executable
add_executable(benchmark_prover tests/prover_benchmark.cpp)
target_link_libraries(benchmark_prover autoreason benchmark::benchmark Threads::Threads)

# Add test
add_test(NAME prover_test COMMAND prover_test)
