# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=skylake -instruction-tables < %s | FileCheck %s

xgetbv

xrstor  (%rax)

xrstors (%rax)

xsave   (%rax)

xsetbv

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  2      2     0.50                  U     xgetbv
# CHECK-NEXT:  31     37    8.00    *      *      U     xrstor	(%rax)
# CHECK-NEXT:  31     37    8.00    *      *      U     xrstors	(%rax)
# CHECK-NEXT:  40     42    11.00   *      *      U     xsave	(%rax)
# CHECK-NEXT:  5      5     1.25    *      *      U     xsetbv

# CHECK:      Resources:
# CHECK-NEXT: [0]   - SKLDivider
# CHECK-NEXT: [1]   - SKLFPDivider
# CHECK-NEXT: [2]   - SKLPort0
# CHECK-NEXT: [3]   - SKLPort1
# CHECK-NEXT: [4]   - SKLPort2
# CHECK-NEXT: [5]   - SKLPort3
# CHECK-NEXT: [6]   - SKLPort4
# CHECK-NEXT: [7]   - SKLPort5
# CHECK-NEXT: [8]   - SKLPort6
# CHECK-NEXT: [9]   - SKLPort7

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]
# CHECK-NEXT:  -      -     19.00  20.50  1.83   1.83   1.00   18.50  46.00  0.33

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    Instructions:
# CHECK-NEXT:  -      -     0.50   0.50    -      -      -     0.50   0.50    -     xgetbv
# CHECK-NEXT:  -      -     5.25   6.25   0.50   0.50    -     5.25   13.25   -     xrstor	(%rax)
# CHECK-NEXT:  -      -     5.25   6.25   0.50   0.50    -     5.25   13.25   -     xrstors	(%rax)
# CHECK-NEXT:  -      -     6.50   6.50   0.83   0.83   1.00   6.50   17.50  0.33   xsave	(%rax)
# CHECK-NEXT:  -      -     1.50   1.00    -      -      -     1.00   1.50    -     xsetbv
