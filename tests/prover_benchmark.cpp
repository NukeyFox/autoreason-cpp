#include "autoreason/prover.h"
#include <benchmark/benchmark.h>

#ifdef __VALGRIND__
#include <valgrind/callgrind.h>  // Include Valgrind client request header
#include <cstdio>                // Include for printf debugging
#endif

// Simple benchmark for proving a simple formula
static void BM_SimpleProof(benchmark::State& state) {
    autoreason::Prover prover;

    for (auto _ : state) {
        #ifdef __VALGRIND__
        printf("Starting profiling for SimpleProof...\n");
        CALLGRIND_TOGGLE_COLLECT;  // Start profiling
        #endif

        prover.prove("A -> B");  // Your function to profile

        #ifdef __VALGRIND__
        CALLGRIND_TOGGLE_COLLECT;  // Stop profiling
        printf("Stopping profiling for SimpleProof...\n");
        #endif
    }
}
BENCHMARK(BM_SimpleProof);

// Benchmark for proving a more complex formula
static void BM_ComplexProof(benchmark::State& state) {
    autoreason::Prover prover;

    for (auto _ : state) {
        #ifdef __VALGRIND__
        printf("Starting profiling for ComplexProof...\n");
        CALLGRIND_TOGGLE_COLLECT;  // Start profiling
        #endif

        prover.prove("(A & B) -> (C | D)");  // Your function to profile

        #ifdef __VALGRIND__
        CALLGRIND_TOGGLE_COLLECT;  // Stop profiling
        printf("Stopping profiling for ComplexProof...\n");
        #endif
    }
}
BENCHMARK(BM_ComplexProof);

BENCHMARK_MAIN();  // Main function for Google Benchmark
