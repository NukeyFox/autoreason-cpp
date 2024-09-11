#include "autoreason/prover.h"
#include <gtest/gtest.h>

TEST(ProverTest, SimpleProof) {
    autoreason::Prover prover;
    EXPECT_TRUE(prover.prove("A -> B"));
}

TEST(ProverTest, AnotherProof) {
    autoreason::Prover prover;
    EXPECT_FALSE(prover.prove("A & !A"));  // Example of a formula that should not be provable
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
