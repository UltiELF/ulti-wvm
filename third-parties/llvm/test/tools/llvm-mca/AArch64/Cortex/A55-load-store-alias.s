# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=aarch64 -mcpu=cortex-a55 -timeline --iterations=3 -noalias=false < %s | FileCheck %s

# PR50483: Execution of loads and stores should not overlap if flag -noalias is set to false.

str x1, [x10]
str x1, [x10]
ldr x2, [x10]
nop
ldr x2, [x10]
ldr x3, [x10]

# CHECK:      Iterations:        3
# CHECK-NEXT: Instructions:      18
# CHECK-NEXT: Total Cycles:      31
# CHECK-NEXT: Total uOps:        18

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.58
# CHECK-NEXT: IPC:               0.58
# CHECK-NEXT: Block RThroughput: 3.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      1     1.00           *            str	x1, [x10]
# CHECK-NEXT:  1      1     1.00           *            str	x1, [x10]
# CHECK-NEXT:  1      3     1.00    *                   ldr	x2, [x10]
# CHECK-NEXT:  1      1     1.00    *      *      U     nop
# CHECK-NEXT:  1      3     1.00    *                   ldr	x2, [x10]
# CHECK-NEXT:  1      3     1.00    *                   ldr	x3, [x10]

# CHECK:      Resources:
# CHECK-NEXT: [0.0] - CortexA55UnitALU
# CHECK-NEXT: [0.1] - CortexA55UnitALU
# CHECK-NEXT: [1]   - CortexA55UnitB
# CHECK-NEXT: [2]   - CortexA55UnitDiv
# CHECK-NEXT: [3.0] - CortexA55UnitFPALU
# CHECK-NEXT: [3.1] - CortexA55UnitFPALU
# CHECK-NEXT: [4]   - CortexA55UnitFPDIV
# CHECK-NEXT: [5.0] - CortexA55UnitFPMAC
# CHECK-NEXT: [5.1] - CortexA55UnitFPMAC
# CHECK-NEXT: [6]   - CortexA55UnitLd
# CHECK-NEXT: [7]   - CortexA55UnitMAC
# CHECK-NEXT: [8]   - CortexA55UnitSt

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0.0]  [0.1]  [1]    [2]    [3.0]  [3.1]  [4]    [5.0]  [5.1]  [6]    [7]    [8]
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -     3.00    -     2.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0.0]  [0.1]  [1]    [2]    [3.0]  [3.1]  [4]    [5.0]  [5.1]  [6]    [7]    [8]    Instructions:
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00   str	x1, [x10]
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -      -      -     1.00   str	x1, [x10]
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -     ldr	x2, [x10]
# CHECK-NEXT:  -      -     1.00    -      -      -      -      -      -      -      -      -     nop
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -     ldr	x2, [x10]
# CHECK-NEXT:  -      -      -      -      -      -      -      -      -     1.00    -      -     ldr	x3, [x10]

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789          0
# CHECK-NEXT: Index     0123456789          0123456789

# CHECK:      [0,0]     DE   .    .    .    .    .    .   str	x1, [x10]
# CHECK-NEXT: [0,1]     .DE  .    .    .    .    .    .   str	x1, [x10]
# CHECK-NEXT: [0,2]     . DeeE    .    .    .    .    .   ldr	x2, [x10]
# CHECK-NEXT: [0,3]     .    DE   .    .    .    .    .   nop
# CHECK-NEXT: [0,4]     .    .DeeE.    .    .    .    .   ldr	x2, [x10]
# CHECK-NEXT: [0,5]     .    . DeeE    .    .    .    .   ldr	x3, [x10]
# CHECK-NEXT: [1,0]     .    .    DE   .    .    .    .   str	x1, [x10]
# CHECK-NEXT: [1,1]     .    .    .DE  .    .    .    .   str	x1, [x10]
# CHECK-NEXT: [1,2]     .    .    . DeeE    .    .    .   ldr	x2, [x10]
# CHECK-NEXT: [1,3]     .    .    .    DE   .    .    .   nop
# CHECK-NEXT: [1,4]     .    .    .    .DeeE.    .    .   ldr	x2, [x10]
# CHECK-NEXT: [1,5]     .    .    .    . DeeE    .    .   ldr	x3, [x10]
# CHECK-NEXT: [2,0]     .    .    .    .    DE   .    .   str	x1, [x10]
# CHECK-NEXT: [2,1]     .    .    .    .    .DE  .    .   str	x1, [x10]
# CHECK-NEXT: [2,2]     .    .    .    .    . DeeE    .   ldr	x2, [x10]
# CHECK-NEXT: [2,3]     .    .    .    .    .    DE   .   nop
# CHECK-NEXT: [2,4]     .    .    .    .    .    .DeeE.   ldr	x2, [x10]
# CHECK-NEXT: [2,5]     .    .    .    .    .    . DeeE   ldr	x3, [x10]

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     3     0.0    0.0    0.0       str	x1, [x10]
# CHECK-NEXT: 1.     3     0.0    0.0    0.0       str	x1, [x10]
# CHECK-NEXT: 2.     3     0.0    0.0    0.0       ldr	x2, [x10]
# CHECK-NEXT: 3.     3     0.0    0.0    0.0       nop
# CHECK-NEXT: 4.     3     0.0    0.0    0.0       ldr	x2, [x10]
# CHECK-NEXT: 5.     3     0.0    0.0    0.0       ldr	x3, [x10]
# CHECK-NEXT:        3     0.0    0.0    0.0       <total>
