#ifndef AUTOREASON_PROVER_H
#define AUTOREASON_PROVER_H

#include <string>

namespace autoreason {
    class Prover {
    public:
        Prover();
        bool prove(const std::string& formula);
    };
}

#endif // AUTOREASON_PROVER_H
