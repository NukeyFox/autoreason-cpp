#include "autoreason/prover.h"
#include <benchmark/benchmark.h>

static void BM_SimpleProof(benchmark::State& state) {
    autoreason::Prover prover;
    for (auto _ : state) {
        prover.prove("A -> B");
    }
}
BENCHMARK(BM_SimpleProof);

static void BM_ComplexProof(benchmark::State& state) {
    autoreason::Prover prover;
    for (auto _ : state) {
        prover.prove("(A & B) -> (C | D)");
    }
}
BENCHMARK(BM_ComplexProof);

BENCHMARK_MAIN();  // Main function for Google Benchmark
