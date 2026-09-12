PP0 = A & {4{B[0]}}
PP1 = A & {4{B[1]}}
PP2 = A & {4{B[2]}}
PP3 = A & {4{B[3]}}

Product = PP0
        + (PP1 << 1)
        + (PP2 << 2)
        + (PP3 << 3)
