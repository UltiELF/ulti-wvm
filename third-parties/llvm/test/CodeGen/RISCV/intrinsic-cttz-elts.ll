; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=riscv32 < %s | FileCheck %s -check-prefix=RV32
; RUN: llc -mtriple=riscv64 < %s | FileCheck %s -check-prefix=RV64

; FIXED WIDTH

define i16 @ctz_v4i32(<4 x i32> %a) {
; RV32-LABEL: ctz_v4i32:
; RV32:       # %bb.0:
; RV32-NEXT:    lw a3, 0(a0)
; RV32-NEXT:    lw a1, 4(a0)
; RV32-NEXT:    lw a2, 12(a0)
; RV32-NEXT:    lw a4, 8(a0)
; RV32-NEXT:    seqz a0, a3
; RV32-NEXT:    addi a0, a0, -1
; RV32-NEXT:    andi a0, a0, 4
; RV32-NEXT:    seqz a3, a4
; RV32-NEXT:    addi a3, a3, -1
; RV32-NEXT:    andi a3, a3, 2
; RV32-NEXT:    bltu a3, a0, .LBB0_2
; RV32-NEXT:  # %bb.1:
; RV32-NEXT:    mv a0, a3
; RV32-NEXT:  .LBB0_2:
; RV32-NEXT:    snez a2, a2
; RV32-NEXT:    seqz a1, a1
; RV32-NEXT:    addi a1, a1, -1
; RV32-NEXT:    andi a1, a1, 3
; RV32-NEXT:    bltu a2, a1, .LBB0_4
; RV32-NEXT:  # %bb.3:
; RV32-NEXT:    mv a1, a2
; RV32-NEXT:  .LBB0_4:
; RV32-NEXT:    bltu a1, a0, .LBB0_6
; RV32-NEXT:  # %bb.5:
; RV32-NEXT:    mv a0, a1
; RV32-NEXT:  .LBB0_6:
; RV32-NEXT:    li a1, 4
; RV32-NEXT:    sub a1, a1, a0
; RV32-NEXT:    andi a0, a1, 255
; RV32-NEXT:    ret
;
; RV64-LABEL: ctz_v4i32:
; RV64:       # %bb.0:
; RV64-NEXT:    lw a3, 0(a0)
; RV64-NEXT:    lw a1, 8(a0)
; RV64-NEXT:    lw a2, 24(a0)
; RV64-NEXT:    lw a4, 16(a0)
; RV64-NEXT:    seqz a0, a3
; RV64-NEXT:    addi a0, a0, -1
; RV64-NEXT:    andi a0, a0, 4
; RV64-NEXT:    seqz a3, a4
; RV64-NEXT:    addi a3, a3, -1
; RV64-NEXT:    andi a3, a3, 2
; RV64-NEXT:    bltu a3, a0, .LBB0_2
; RV64-NEXT:  # %bb.1:
; RV64-NEXT:    mv a0, a3
; RV64-NEXT:  .LBB0_2:
; RV64-NEXT:    snez a2, a2
; RV64-NEXT:    seqz a1, a1
; RV64-NEXT:    addi a1, a1, -1
; RV64-NEXT:    andi a1, a1, 3
; RV64-NEXT:    bltu a2, a1, .LBB0_4
; RV64-NEXT:  # %bb.3:
; RV64-NEXT:    mv a1, a2
; RV64-NEXT:  .LBB0_4:
; RV64-NEXT:    bltu a1, a0, .LBB0_6
; RV64-NEXT:  # %bb.5:
; RV64-NEXT:    mv a0, a1
; RV64-NEXT:  .LBB0_6:
; RV64-NEXT:    li a1, 4
; RV64-NEXT:    subw a1, a1, a0
; RV64-NEXT:    andi a0, a1, 255
; RV64-NEXT:    ret
  %res = call i16 @llvm.experimental.cttz.elts.i16.v4i32(<4 x i32> %a, i1 0)
  ret i16 %res
}

; ZERO IS POISON

define i32 @ctz_v2i1_poison(<2 x i1> %a) {
; RV32-LABEL: ctz_v2i1_poison:
; RV32:       # %bb.0:
; RV32-NEXT:    andi a1, a1, 1
; RV32-NEXT:    slli a0, a0, 31
; RV32-NEXT:    srai a0, a0, 31
; RV32-NEXT:    andi a0, a0, 2
; RV32-NEXT:    bltu a1, a0, .LBB1_2
; RV32-NEXT:  # %bb.1:
; RV32-NEXT:    mv a0, a1
; RV32-NEXT:  .LBB1_2:
; RV32-NEXT:    li a1, 2
; RV32-NEXT:    sub a1, a1, a0
; RV32-NEXT:    andi a0, a1, 255
; RV32-NEXT:    ret
;
; RV64-LABEL: ctz_v2i1_poison:
; RV64:       # %bb.0:
; RV64-NEXT:    andi a1, a1, 1
; RV64-NEXT:    slli a0, a0, 63
; RV64-NEXT:    srai a0, a0, 63
; RV64-NEXT:    andi a0, a0, 2
; RV64-NEXT:    bltu a1, a0, .LBB1_2
; RV64-NEXT:  # %bb.1:
; RV64-NEXT:    mv a0, a1
; RV64-NEXT:  .LBB1_2:
; RV64-NEXT:    li a1, 2
; RV64-NEXT:    subw a1, a1, a0
; RV64-NEXT:    andi a0, a1, 255
; RV64-NEXT:    ret
  %res = call i32 @llvm.experimental.cttz.elts.i32.v2i1(<2 x i1> %a, i1 1)
  ret i32 %res
}

declare i32 @llvm.experimental.cttz.elts.i32.v2i1(<2 x i1>, i1)
declare i16 @llvm.experimental.cttz.elts.i16.v4i32(<4 x i32>, i1)
