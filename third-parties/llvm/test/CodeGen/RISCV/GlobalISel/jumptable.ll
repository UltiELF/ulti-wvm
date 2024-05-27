; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -code-model=small -verify-machineinstrs < %s \
; RUN:   -global-isel | FileCheck %s -check-prefixes=RV32I-SMALL
; RUN: llc -mtriple=riscv32 -code-model=medium -verify-machineinstrs < %s \
; RUN:   -global-isel | FileCheck %s -check-prefixes=RV32I-MEDIUM
; RUN: llc -mtriple=riscv32 -relocation-model=pic -verify-machineinstrs < %s \
; RUN:   -global-isel | FileCheck %s -check-prefixes=RV32I-PIC
; RUN: llc -mtriple=riscv64 -code-model=small -verify-machineinstrs < %s \
; RUN:   -global-isel | FileCheck %s -check-prefixes=RV64I-SMALL
; RUN: llc -mtriple=riscv64 -code-model=medium -verify-machineinstrs < %s \
; RUN:   -global-isel | FileCheck %s -check-prefixes=RV64I-MEDIUM
; RUN: llc -mtriple=riscv64 -relocation-model=pic -verify-machineinstrs < %s \
; RUN:   -global-isel | FileCheck %s -check-prefixes=RV64I-PIC

define void @above_threshold(i32 signext %in, ptr %out) nounwind {
; RV32I-SMALL-LABEL: above_threshold:
; RV32I-SMALL:       # %bb.0: # %entry
; RV32I-SMALL-NEXT:    li a2, 5
; RV32I-SMALL-NEXT:    addi a0, a0, -1
; RV32I-SMALL-NEXT:    bltu a2, a0, .LBB0_9
; RV32I-SMALL-NEXT:  # %bb.1: # %entry
; RV32I-SMALL-NEXT:    lui a2, %hi(.LJTI0_0)
; RV32I-SMALL-NEXT:    addi a2, a2, %lo(.LJTI0_0)
; RV32I-SMALL-NEXT:    slli a0, a0, 2
; RV32I-SMALL-NEXT:    add a0, a2, a0
; RV32I-SMALL-NEXT:    lw a0, 0(a0)
; RV32I-SMALL-NEXT:    jr a0
; RV32I-SMALL-NEXT:  .LBB0_2: # %bb1
; RV32I-SMALL-NEXT:    li a0, 4
; RV32I-SMALL-NEXT:    j .LBB0_8
; RV32I-SMALL-NEXT:  .LBB0_3: # %bb5
; RV32I-SMALL-NEXT:    li a0, 100
; RV32I-SMALL-NEXT:    j .LBB0_8
; RV32I-SMALL-NEXT:  .LBB0_4: # %bb3
; RV32I-SMALL-NEXT:    li a0, 2
; RV32I-SMALL-NEXT:    j .LBB0_8
; RV32I-SMALL-NEXT:  .LBB0_5: # %bb4
; RV32I-SMALL-NEXT:    li a0, 1
; RV32I-SMALL-NEXT:    j .LBB0_8
; RV32I-SMALL-NEXT:  .LBB0_6: # %bb2
; RV32I-SMALL-NEXT:    li a0, 3
; RV32I-SMALL-NEXT:    j .LBB0_8
; RV32I-SMALL-NEXT:  .LBB0_7: # %bb6
; RV32I-SMALL-NEXT:    li a0, 200
; RV32I-SMALL-NEXT:  .LBB0_8: # %exit
; RV32I-SMALL-NEXT:    sw a0, 0(a1)
; RV32I-SMALL-NEXT:  .LBB0_9: # %exit
; RV32I-SMALL-NEXT:    ret
;
; RV32I-MEDIUM-LABEL: above_threshold:
; RV32I-MEDIUM:       # %bb.0: # %entry
; RV32I-MEDIUM-NEXT:    li a2, 5
; RV32I-MEDIUM-NEXT:    addi a0, a0, -1
; RV32I-MEDIUM-NEXT:    bltu a2, a0, .LBB0_9
; RV32I-MEDIUM-NEXT:  # %bb.1: # %entry
; RV32I-MEDIUM-NEXT:  .Lpcrel_hi0:
; RV32I-MEDIUM-NEXT:    auipc a2, %pcrel_hi(.LJTI0_0)
; RV32I-MEDIUM-NEXT:    addi a2, a2, %pcrel_lo(.Lpcrel_hi0)
; RV32I-MEDIUM-NEXT:    slli a0, a0, 2
; RV32I-MEDIUM-NEXT:    add a0, a2, a0
; RV32I-MEDIUM-NEXT:    lw a0, 0(a0)
; RV32I-MEDIUM-NEXT:    jr a0
; RV32I-MEDIUM-NEXT:  .LBB0_2: # %bb1
; RV32I-MEDIUM-NEXT:    li a0, 4
; RV32I-MEDIUM-NEXT:    j .LBB0_8
; RV32I-MEDIUM-NEXT:  .LBB0_3: # %bb5
; RV32I-MEDIUM-NEXT:    li a0, 100
; RV32I-MEDIUM-NEXT:    j .LBB0_8
; RV32I-MEDIUM-NEXT:  .LBB0_4: # %bb3
; RV32I-MEDIUM-NEXT:    li a0, 2
; RV32I-MEDIUM-NEXT:    j .LBB0_8
; RV32I-MEDIUM-NEXT:  .LBB0_5: # %bb4
; RV32I-MEDIUM-NEXT:    li a0, 1
; RV32I-MEDIUM-NEXT:    j .LBB0_8
; RV32I-MEDIUM-NEXT:  .LBB0_6: # %bb2
; RV32I-MEDIUM-NEXT:    li a0, 3
; RV32I-MEDIUM-NEXT:    j .LBB0_8
; RV32I-MEDIUM-NEXT:  .LBB0_7: # %bb6
; RV32I-MEDIUM-NEXT:    li a0, 200
; RV32I-MEDIUM-NEXT:  .LBB0_8: # %exit
; RV32I-MEDIUM-NEXT:    sw a0, 0(a1)
; RV32I-MEDIUM-NEXT:  .LBB0_9: # %exit
; RV32I-MEDIUM-NEXT:    ret
;
; RV32I-PIC-LABEL: above_threshold:
; RV32I-PIC:       # %bb.0: # %entry
; RV32I-PIC-NEXT:    li a2, 5
; RV32I-PIC-NEXT:    addi a0, a0, -1
; RV32I-PIC-NEXT:    bltu a2, a0, .LBB0_9
; RV32I-PIC-NEXT:  # %bb.1: # %entry
; RV32I-PIC-NEXT:  .Lpcrel_hi0:
; RV32I-PIC-NEXT:    auipc a2, %pcrel_hi(.LJTI0_0)
; RV32I-PIC-NEXT:    addi a2, a2, %pcrel_lo(.Lpcrel_hi0)
; RV32I-PIC-NEXT:    slli a0, a0, 2
; RV32I-PIC-NEXT:    add a0, a2, a0
; RV32I-PIC-NEXT:    lw a0, 0(a0)
; RV32I-PIC-NEXT:    add a0, a0, a2
; RV32I-PIC-NEXT:    jr a0
; RV32I-PIC-NEXT:  .LBB0_2: # %bb1
; RV32I-PIC-NEXT:    li a0, 4
; RV32I-PIC-NEXT:    j .LBB0_8
; RV32I-PIC-NEXT:  .LBB0_3: # %bb5
; RV32I-PIC-NEXT:    li a0, 100
; RV32I-PIC-NEXT:    j .LBB0_8
; RV32I-PIC-NEXT:  .LBB0_4: # %bb3
; RV32I-PIC-NEXT:    li a0, 2
; RV32I-PIC-NEXT:    j .LBB0_8
; RV32I-PIC-NEXT:  .LBB0_5: # %bb4
; RV32I-PIC-NEXT:    li a0, 1
; RV32I-PIC-NEXT:    j .LBB0_8
; RV32I-PIC-NEXT:  .LBB0_6: # %bb2
; RV32I-PIC-NEXT:    li a0, 3
; RV32I-PIC-NEXT:    j .LBB0_8
; RV32I-PIC-NEXT:  .LBB0_7: # %bb6
; RV32I-PIC-NEXT:    li a0, 200
; RV32I-PIC-NEXT:  .LBB0_8: # %exit
; RV32I-PIC-NEXT:    sw a0, 0(a1)
; RV32I-PIC-NEXT:  .LBB0_9: # %exit
; RV32I-PIC-NEXT:    ret
;
; RV64I-SMALL-LABEL: above_threshold:
; RV64I-SMALL:       # %bb.0: # %entry
; RV64I-SMALL-NEXT:    li a2, 5
; RV64I-SMALL-NEXT:    sext.w a0, a0
; RV64I-SMALL-NEXT:    addi a0, a0, -1
; RV64I-SMALL-NEXT:    bltu a2, a0, .LBB0_9
; RV64I-SMALL-NEXT:  # %bb.1: # %entry
; RV64I-SMALL-NEXT:    lui a2, %hi(.LJTI0_0)
; RV64I-SMALL-NEXT:    addi a2, a2, %lo(.LJTI0_0)
; RV64I-SMALL-NEXT:    slli a0, a0, 2
; RV64I-SMALL-NEXT:    add a0, a2, a0
; RV64I-SMALL-NEXT:    lw a0, 0(a0)
; RV64I-SMALL-NEXT:    jr a0
; RV64I-SMALL-NEXT:  .LBB0_2: # %bb1
; RV64I-SMALL-NEXT:    li a0, 4
; RV64I-SMALL-NEXT:    j .LBB0_8
; RV64I-SMALL-NEXT:  .LBB0_3: # %bb5
; RV64I-SMALL-NEXT:    li a0, 100
; RV64I-SMALL-NEXT:    j .LBB0_8
; RV64I-SMALL-NEXT:  .LBB0_4: # %bb3
; RV64I-SMALL-NEXT:    li a0, 2
; RV64I-SMALL-NEXT:    j .LBB0_8
; RV64I-SMALL-NEXT:  .LBB0_5: # %bb4
; RV64I-SMALL-NEXT:    li a0, 1
; RV64I-SMALL-NEXT:    j .LBB0_8
; RV64I-SMALL-NEXT:  .LBB0_6: # %bb2
; RV64I-SMALL-NEXT:    li a0, 3
; RV64I-SMALL-NEXT:    j .LBB0_8
; RV64I-SMALL-NEXT:  .LBB0_7: # %bb6
; RV64I-SMALL-NEXT:    li a0, 200
; RV64I-SMALL-NEXT:  .LBB0_8: # %exit
; RV64I-SMALL-NEXT:    sw a0, 0(a1)
; RV64I-SMALL-NEXT:  .LBB0_9: # %exit
; RV64I-SMALL-NEXT:    ret
;
; RV64I-MEDIUM-LABEL: above_threshold:
; RV64I-MEDIUM:       # %bb.0: # %entry
; RV64I-MEDIUM-NEXT:    li a2, 5
; RV64I-MEDIUM-NEXT:    sext.w a0, a0
; RV64I-MEDIUM-NEXT:    addi a0, a0, -1
; RV64I-MEDIUM-NEXT:    bltu a2, a0, .LBB0_9
; RV64I-MEDIUM-NEXT:  # %bb.1: # %entry
; RV64I-MEDIUM-NEXT:  .Lpcrel_hi0:
; RV64I-MEDIUM-NEXT:    auipc a2, %pcrel_hi(.LJTI0_0)
; RV64I-MEDIUM-NEXT:    addi a2, a2, %pcrel_lo(.Lpcrel_hi0)
; RV64I-MEDIUM-NEXT:    slli a0, a0, 3
; RV64I-MEDIUM-NEXT:    add a0, a2, a0
; RV64I-MEDIUM-NEXT:    ld a0, 0(a0)
; RV64I-MEDIUM-NEXT:    jr a0
; RV64I-MEDIUM-NEXT:  .LBB0_2: # %bb1
; RV64I-MEDIUM-NEXT:    li a0, 4
; RV64I-MEDIUM-NEXT:    j .LBB0_8
; RV64I-MEDIUM-NEXT:  .LBB0_3: # %bb5
; RV64I-MEDIUM-NEXT:    li a0, 100
; RV64I-MEDIUM-NEXT:    j .LBB0_8
; RV64I-MEDIUM-NEXT:  .LBB0_4: # %bb3
; RV64I-MEDIUM-NEXT:    li a0, 2
; RV64I-MEDIUM-NEXT:    j .LBB0_8
; RV64I-MEDIUM-NEXT:  .LBB0_5: # %bb4
; RV64I-MEDIUM-NEXT:    li a0, 1
; RV64I-MEDIUM-NEXT:    j .LBB0_8
; RV64I-MEDIUM-NEXT:  .LBB0_6: # %bb2
; RV64I-MEDIUM-NEXT:    li a0, 3
; RV64I-MEDIUM-NEXT:    j .LBB0_8
; RV64I-MEDIUM-NEXT:  .LBB0_7: # %bb6
; RV64I-MEDIUM-NEXT:    li a0, 200
; RV64I-MEDIUM-NEXT:  .LBB0_8: # %exit
; RV64I-MEDIUM-NEXT:    sw a0, 0(a1)
; RV64I-MEDIUM-NEXT:  .LBB0_9: # %exit
; RV64I-MEDIUM-NEXT:    ret
;
; RV64I-PIC-LABEL: above_threshold:
; RV64I-PIC:       # %bb.0: # %entry
; RV64I-PIC-NEXT:    li a2, 5
; RV64I-PIC-NEXT:    sext.w a0, a0
; RV64I-PIC-NEXT:    addi a0, a0, -1
; RV64I-PIC-NEXT:    bltu a2, a0, .LBB0_9
; RV64I-PIC-NEXT:  # %bb.1: # %entry
; RV64I-PIC-NEXT:  .Lpcrel_hi0:
; RV64I-PIC-NEXT:    auipc a2, %pcrel_hi(.LJTI0_0)
; RV64I-PIC-NEXT:    addi a2, a2, %pcrel_lo(.Lpcrel_hi0)
; RV64I-PIC-NEXT:    slli a0, a0, 2
; RV64I-PIC-NEXT:    add a0, a2, a0
; RV64I-PIC-NEXT:    lw a0, 0(a0)
; RV64I-PIC-NEXT:    add a0, a0, a2
; RV64I-PIC-NEXT:    jr a0
; RV64I-PIC-NEXT:  .LBB0_2: # %bb1
; RV64I-PIC-NEXT:    li a0, 4
; RV64I-PIC-NEXT:    j .LBB0_8
; RV64I-PIC-NEXT:  .LBB0_3: # %bb5
; RV64I-PIC-NEXT:    li a0, 100
; RV64I-PIC-NEXT:    j .LBB0_8
; RV64I-PIC-NEXT:  .LBB0_4: # %bb3
; RV64I-PIC-NEXT:    li a0, 2
; RV64I-PIC-NEXT:    j .LBB0_8
; RV64I-PIC-NEXT:  .LBB0_5: # %bb4
; RV64I-PIC-NEXT:    li a0, 1
; RV64I-PIC-NEXT:    j .LBB0_8
; RV64I-PIC-NEXT:  .LBB0_6: # %bb2
; RV64I-PIC-NEXT:    li a0, 3
; RV64I-PIC-NEXT:    j .LBB0_8
; RV64I-PIC-NEXT:  .LBB0_7: # %bb6
; RV64I-PIC-NEXT:    li a0, 200
; RV64I-PIC-NEXT:  .LBB0_8: # %exit
; RV64I-PIC-NEXT:    sw a0, 0(a1)
; RV64I-PIC-NEXT:  .LBB0_9: # %exit
; RV64I-PIC-NEXT:    ret
entry:
  switch i32 %in, label %exit [
    i32 1, label %bb1
    i32 2, label %bb2
    i32 3, label %bb3
    i32 4, label %bb4
    i32 5, label %bb5
    i32 6, label %bb6
  ]
bb1:
  store i32 4, ptr %out
  br label %exit
bb2:
  store i32 3, ptr %out
  br label %exit
bb3:
  store i32 2, ptr %out
  br label %exit
bb4:
  store i32 1, ptr %out
  br label %exit
bb5:
  store i32 100, ptr %out
  br label %exit
bb6:
  store i32 200, ptr %out
  br label %exit
exit:
  ret void
}
