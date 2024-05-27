; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=riscv64 -mattr=+zbb -verify-machineinstrs < %s | FileCheck %s -check-prefix=RV64ZBB
; RUN: llc -mtriple=riscv32 -mattr=+zbb -verify-machineinstrs < %s | FileCheck %s -check-prefix=RV32ZBB

; RUN: llc -mtriple=riscv32 -verify-machineinstrs < %s | FileCheck %s -check-prefix=RV32I
; RUN: llc -mtriple=riscv64 -verify-machineinstrs < %s | FileCheck %s -check-prefix=RV64I

@global_x = global i32 0, align 4

define signext i32 @ctz_dereferencing_pointer(i64* %b) nounwind {
; RV64ZBB-LABEL: ctz_dereferencing_pointer:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    ld a0, 0(a0)
; RV64ZBB-NEXT:    ctz a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 63
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: ctz_dereferencing_pointer:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    lw a1, 0(a0)
; RV32ZBB-NEXT:    bnez a1, .LBB0_2
; RV32ZBB-NEXT:  # %bb.1: # %entry
; RV32ZBB-NEXT:    lw a0, 4(a0)
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    andi a0, a0, 63
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB0_2:
; RV32ZBB-NEXT:    ctz a0, a1
; RV32ZBB-NEXT:    andi a0, a0, 63
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: ctz_dereferencing_pointer:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lw s2, 0(a0)
; RV32I-NEXT:    lw s4, 4(a0)
; RV32I-NEXT:    neg a0, s2
; RV32I-NEXT:    and a0, s2, a0
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi s1, a1, 1329
; RV32I-NEXT:    mv a1, s1
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    lui a0, %hi(.LCPI0_0)
; RV32I-NEXT:    addi s3, a0, %lo(.LCPI0_0)
; RV32I-NEXT:    neg a0, s4
; RV32I-NEXT:    and a0, s4, a0
; RV32I-NEXT:    mv a1, s1
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    bnez s4, .LBB0_3
; RV32I-NEXT:  # %bb.1: # %entry
; RV32I-NEXT:    li a0, 32
; RV32I-NEXT:    beqz s2, .LBB0_4
; RV32I-NEXT:  .LBB0_2:
; RV32I-NEXT:    srli s0, s0, 27
; RV32I-NEXT:    add s0, s3, s0
; RV32I-NEXT:    lbu a0, 0(s0)
; RV32I-NEXT:    j .LBB0_5
; RV32I-NEXT:  .LBB0_3:
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    add a0, s3, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    bnez s2, .LBB0_2
; RV32I-NEXT:  .LBB0_4: # %entry
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:  .LBB0_5: # %entry
; RV32I-NEXT:    andi a0, a0, 63
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ctz_dereferencing_pointer:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    ld s0, 0(a0)
; RV64I-NEXT:    neg a0, s0
; RV64I-NEXT:    and a0, s0, a0
; RV64I-NEXT:    lui a1, %hi(.LCPI0_0)
; RV64I-NEXT:    ld a1, %lo(.LCPI0_0)(a1)
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    srli a0, a0, 58
; RV64I-NEXT:    lui a1, %hi(.LCPI0_1)
; RV64I-NEXT:    addi a1, a1, %lo(.LCPI0_1)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lbu a0, 0(a0)
; RV64I-NEXT:    seqz a1, s0
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 63
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret




entry:
  %0 = load i64, i64* %b, align 8
  %1 = tail call i64 @llvm.cttz.i64(i64 %0, i1 true)
  %2 = icmp eq i64 %0, 0
  %3 = trunc i64 %1 to i32
  %4 = select i1 %2, i32 0, i32 %3
  ret i32 %4
}

define i64 @ctz_dereferencing_pointer_zext(i32* %b) nounwind {
; RV64ZBB-LABEL: ctz_dereferencing_pointer_zext:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    lw a0, 0(a0)
; RV64ZBB-NEXT:    ctzw a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 31
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: ctz_dereferencing_pointer_zext:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    lw a0, 0(a0)
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    andi a0, a0, 31
; RV32ZBB-NEXT:    li a1, 0
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: ctz_dereferencing_pointer_zext:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lw s0, 0(a0)
; RV32I-NEXT:    neg a0, s0
; RV32I-NEXT:    and a0, s0, a0
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi a1, a1, 1329
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    lui a1, %hi(.LCPI1_0)
; RV32I-NEXT:    addi a1, a1, %lo(.LCPI1_0)
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    seqz a1, s0
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 31
; RV32I-NEXT:    li a1, 0
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ctz_dereferencing_pointer_zext:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lw s0, 0(a0)
; RV64I-NEXT:    neg a0, s0
; RV64I-NEXT:    and a0, s0, a0
; RV64I-NEXT:    lui a1, 30667
; RV64I-NEXT:    addiw a1, a1, 1329
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    srliw a0, a0, 27
; RV64I-NEXT:    lui a1, %hi(.LCPI1_0)
; RV64I-NEXT:    addi a1, a1, %lo(.LCPI1_0)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lbu a0, 0(a0)
; RV64I-NEXT:    seqz a1, s0
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 31
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret




entry:
  %0 = load i32, i32* %b, align 8
  %1 = tail call i32 @llvm.cttz.i32(i32 %0, i1 true)
  %2 = icmp eq i32 %0, 0
  %3 = zext i32 %1 to i64
  %4 = select i1 %2, i64 0, i64 %3
  ret i64 %4
}

define signext i32 @ctz1(i32 signext %x) nounwind {
; RV64ZBB-LABEL: ctz1:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    ctzw a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 31
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: ctz1:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    andi a0, a0, 31
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: ctz1:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    and a0, s0, a0
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi a1, a1, 1329
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    lui a1, %hi(.LCPI2_0)
; RV32I-NEXT:    addi a1, a1, %lo(.LCPI2_0)
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    seqz a1, s0
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 31
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ctz1:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a0
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    and a0, s0, a0
; RV64I-NEXT:    lui a1, 30667
; RV64I-NEXT:    addiw a1, a1, 1329
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    srliw a0, a0, 27
; RV64I-NEXT:    lui a1, %hi(.LCPI2_0)
; RV64I-NEXT:    addi a1, a1, %lo(.LCPI2_0)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lbu a0, 0(a0)
; RV64I-NEXT:    seqz a1, s0
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 31
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret




entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 true)
  %1 = icmp eq i32 %x, 0
  %conv = select i1 %1, i32 0, i32 %0
  ret i32 %conv
}

define signext i32 @ctz1_flipped(i32 signext %x) nounwind {
; RV64ZBB-LABEL: ctz1_flipped:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    ctzw a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 31
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: ctz1_flipped:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    andi a0, a0, 31
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: ctz1_flipped:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    and a0, s0, a0
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi a1, a1, 1329
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    lui a1, %hi(.LCPI3_0)
; RV32I-NEXT:    addi a1, a1, %lo(.LCPI3_0)
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    seqz a1, s0
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 31
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ctz1_flipped:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a0
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    and a0, s0, a0
; RV64I-NEXT:    lui a1, 30667
; RV64I-NEXT:    addiw a1, a1, 1329
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    srliw a0, a0, 27
; RV64I-NEXT:    lui a1, %hi(.LCPI3_0)
; RV64I-NEXT:    addi a1, a1, %lo(.LCPI3_0)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lbu a0, 0(a0)
; RV64I-NEXT:    seqz a1, s0
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 31
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret




entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 true)
  %1 = icmp ne i32 %x, 0
  %conv = select i1 %1, i32 %0, i32 0
  ret i32 %conv
}

define signext i32 @ctz2(i32 signext %x) nounwind {
; RV64ZBB-LABEL: ctz2:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    ctzw a0, a0
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: ctz2:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: ctz2:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    beqz a0, .LBB4_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    neg a1, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi a1, a1, 1329
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    lui a1, %hi(.LCPI4_0)
; RV32I-NEXT:    addi a1, a1, %lo(.LCPI4_0)
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB4_2:
; RV32I-NEXT:    li a0, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ctz2:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    beqz a0, .LBB4_2
; RV64I-NEXT:  # %bb.1: # %cond.false
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    neg a1, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    lui a1, 30667
; RV64I-NEXT:    addiw a1, a1, 1329
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    srliw a0, a0, 27
; RV64I-NEXT:    lui a1, %hi(.LCPI4_0)
; RV64I-NEXT:    addi a1, a1, %lo(.LCPI4_0)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lbu a0, 0(a0)
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB4_2:
; RV64I-NEXT:    li a0, 32
; RV64I-NEXT:    ret




entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 false)
  ret i32 %0
}

define signext i32 @ctz3(i32 signext %x) nounwind {
; RV64ZBB-LABEL: ctz3:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    ctzw a0, a0
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: ctz3:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: ctz3:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    beqz a0, .LBB5_2
; RV32I-NEXT:  # %bb.1: # %cond.false
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    neg a1, a0
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi a1, a1, 1329
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    lui a1, %hi(.LCPI5_0)
; RV32I-NEXT:    addi a1, a1, %lo(.LCPI5_0)
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
; RV32I-NEXT:  .LBB5_2:
; RV32I-NEXT:    li a0, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ctz3:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    beqz a0, .LBB5_2
; RV64I-NEXT:  # %bb.1: # %cond.false
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    neg a1, a0
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    lui a1, 30667
; RV64I-NEXT:    addiw a1, a1, 1329
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    srliw a0, a0, 27
; RV64I-NEXT:    lui a1, %hi(.LCPI5_0)
; RV64I-NEXT:    addi a1, a1, %lo(.LCPI5_0)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lbu a0, 0(a0)
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret
; RV64I-NEXT:  .LBB5_2:
; RV64I-NEXT:    li a0, 32
; RV64I-NEXT:    ret




entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 false)
  ret i32 %0
}

define signext i32 @ctz4(i64 %b) nounwind {
; RV64ZBB-LABEL: ctz4:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    ctz a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 63
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: ctz4:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    bnez a0, .LBB6_2
; RV32ZBB-NEXT:  # %bb.1: # %entry
; RV32ZBB-NEXT:    ctz a0, a1
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    andi a0, a0, 63
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB6_2:
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    andi a0, a0, 63
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: ctz4:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s2, a1
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    and a0, s0, a0
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi s3, a1, 1329
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    mv s1, a0
; RV32I-NEXT:    lui a0, %hi(.LCPI6_0)
; RV32I-NEXT:    addi s4, a0, %lo(.LCPI6_0)
; RV32I-NEXT:    neg a0, s2
; RV32I-NEXT:    and a0, s2, a0
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    bnez s2, .LBB6_3
; RV32I-NEXT:  # %bb.1: # %entry
; RV32I-NEXT:    li a0, 32
; RV32I-NEXT:    beqz s0, .LBB6_4
; RV32I-NEXT:  .LBB6_2:
; RV32I-NEXT:    srli s1, s1, 27
; RV32I-NEXT:    add s1, s4, s1
; RV32I-NEXT:    lbu a0, 0(s1)
; RV32I-NEXT:    j .LBB6_5
; RV32I-NEXT:  .LBB6_3:
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    add a0, s4, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    bnez s0, .LBB6_2
; RV32I-NEXT:  .LBB6_4: # %entry
; RV32I-NEXT:    addi a0, a0, 32
; RV32I-NEXT:  .LBB6_5: # %entry
; RV32I-NEXT:    andi a0, a0, 63
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ctz4:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a0
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    and a0, s0, a0
; RV64I-NEXT:    lui a1, %hi(.LCPI6_0)
; RV64I-NEXT:    ld a1, %lo(.LCPI6_0)(a1)
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    srli a0, a0, 58
; RV64I-NEXT:    lui a1, %hi(.LCPI6_1)
; RV64I-NEXT:    addi a1, a1, %lo(.LCPI6_1)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lbu a0, 0(a0)
; RV64I-NEXT:    seqz a1, s0
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 63
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret




entry:
  %0 = tail call i64 @llvm.cttz.i64(i64 %b, i1 true)
  %1 = icmp eq i64 %b, 0
  %2 = trunc i64 %0 to i32
  %3 = select i1 %1, i32 0, i32 %2
  ret i32 %3
}

define signext i32 @ctlz(i64 %b) nounwind {
; RV64ZBB-LABEL: ctlz:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    clz a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 63
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: ctlz:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    bnez a1, .LBB7_2
; RV32ZBB-NEXT:  # %bb.1: # %entry
; RV32ZBB-NEXT:    clz a0, a0
; RV32ZBB-NEXT:    addi a0, a0, 32
; RV32ZBB-NEXT:    andi a0, a0, 63
; RV32ZBB-NEXT:    ret
; RV32ZBB-NEXT:  .LBB7_2:
; RV32ZBB-NEXT:    clz a0, a1
; RV32ZBB-NEXT:    andi a0, a0, 63
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: ctlz:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -32
; RV32I-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s5, 4(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s6, 0(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a1
; RV32I-NEXT:    mv s2, a0
; RV32I-NEXT:    srli a0, a1, 1
; RV32I-NEXT:    or a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 16
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    lui a2, 349525
; RV32I-NEXT:    addi s4, a2, 1365
; RV32I-NEXT:    and a1, a1, s4
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    lui a1, 209715
; RV32I-NEXT:    addi s5, a1, 819
; RV32I-NEXT:    and a1, a0, s5
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s5
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    lui a1, 61681
; RV32I-NEXT:    addi s6, a1, -241
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    lui a1, 4112
; RV32I-NEXT:    addi s3, a1, 257
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    mv s1, a0
; RV32I-NEXT:    srli a0, s2, 1
; RV32I-NEXT:    or a0, s2, a0
; RV32I-NEXT:    srli a1, a0, 2
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 8
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    srli a1, a0, 16
; RV32I-NEXT:    or a0, a0, a1
; RV32I-NEXT:    not a0, a0
; RV32I-NEXT:    srli a1, a0, 1
; RV32I-NEXT:    and a1, a1, s4
; RV32I-NEXT:    sub a0, a0, a1
; RV32I-NEXT:    and a1, a0, s5
; RV32I-NEXT:    srli a0, a0, 2
; RV32I-NEXT:    and a0, a0, s5
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    srli a1, a0, 4
; RV32I-NEXT:    add a0, a0, a1
; RV32I-NEXT:    and a0, a0, s6
; RV32I-NEXT:    mv a1, s3
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    bnez s0, .LBB7_2
; RV32I-NEXT:  # %bb.1: # %entry
; RV32I-NEXT:    srli a0, a0, 24
; RV32I-NEXT:    addi s1, a0, 32
; RV32I-NEXT:    j .LBB7_3
; RV32I-NEXT:  .LBB7_2:
; RV32I-NEXT:    srli s1, s1, 24
; RV32I-NEXT:  .LBB7_3: # %entry
; RV32I-NEXT:    andi a0, s1, 63
; RV32I-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s5, 4(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s6, 0(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 32
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ctlz:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 2
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 8
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 16
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    srli a1, a0, 32
; RV64I-NEXT:    or a0, a0, a1
; RV64I-NEXT:    not a0, a0
; RV64I-NEXT:    srli a1, a0, 1
; RV64I-NEXT:    lui a2, 349525
; RV64I-NEXT:    addiw a2, a2, 1365
; RV64I-NEXT:    slli a3, a2, 32
; RV64I-NEXT:    add a2, a2, a3
; RV64I-NEXT:    and a1, a1, a2
; RV64I-NEXT:    sub a0, a0, a1
; RV64I-NEXT:    lui a1, 209715
; RV64I-NEXT:    addiw a1, a1, 819
; RV64I-NEXT:    slli a2, a1, 32
; RV64I-NEXT:    add a1, a1, a2
; RV64I-NEXT:    and a2, a0, a1
; RV64I-NEXT:    srli a0, a0, 2
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    add a0, a2, a0
; RV64I-NEXT:    srli a1, a0, 4
; RV64I-NEXT:    add a0, a0, a1
; RV64I-NEXT:    lui a1, 61681
; RV64I-NEXT:    addiw a1, a1, -241
; RV64I-NEXT:    slli a2, a1, 32
; RV64I-NEXT:    add a1, a1, a2
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    lui a1, 4112
; RV64I-NEXT:    addiw a1, a1, 257
; RV64I-NEXT:    slli a2, a1, 32
; RV64I-NEXT:    add a1, a1, a2
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    slli a0, a0, 2
; RV64I-NEXT:    srli a0, a0, 58
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret




entry:
  %0 = tail call i64 @llvm.ctlz.i64(i64 %b, i1 true)
  %1 = icmp eq i64 %b, 0
  %2 = trunc i64 %0 to i32
  %3 = select i1 %1, i32 0, i32 %2
  ret i32 %3
}

define signext i32 @ctz5(i32 signext %x) nounwind {
; RV64ZBB-LABEL: ctz5:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    ctzw a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 31
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: ctz5:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    andi a0, a0, 31
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: ctz5:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    and a0, s0, a0
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi a1, a1, 1329
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    lui a1, %hi(.LCPI8_0)
; RV32I-NEXT:    addi a1, a1, %lo(.LCPI8_0)
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    seqz a1, s0
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 31
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ctz5:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a0
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    and a0, s0, a0
; RV64I-NEXT:    lui a1, 30667
; RV64I-NEXT:    addiw a1, a1, 1329
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    srliw a0, a0, 27
; RV64I-NEXT:    lui a1, %hi(.LCPI8_0)
; RV64I-NEXT:    addi a1, a1, %lo(.LCPI8_0)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lbu a0, 0(a0)
; RV64I-NEXT:    seqz a1, s0
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 31
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret




entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 true)
  %1 = icmp eq i32 %x, 0
  %conv = select i1 %1, i32 0, i32 %0
  ret i32 %conv
}

define signext i32 @ctz6(i32 signext %x) nounwind {
; RV64ZBB-LABEL: ctz6:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    ctzw a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 31
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: ctz6:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    andi a0, a0, 31
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: ctz6:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    mv s0, a0
; RV32I-NEXT:    neg a0, a0
; RV32I-NEXT:    and a0, s0, a0
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi a1, a1, 1329
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    lui a1, %hi(.LCPI9_0)
; RV32I-NEXT:    addi a1, a1, %lo(.LCPI9_0)
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    seqz a1, s0
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 31
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: ctz6:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    mv s0, a0
; RV64I-NEXT:    neg a0, a0
; RV64I-NEXT:    and a0, s0, a0
; RV64I-NEXT:    lui a1, 30667
; RV64I-NEXT:    addiw a1, a1, 1329
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    srliw a0, a0, 27
; RV64I-NEXT:    lui a1, %hi(.LCPI9_0)
; RV64I-NEXT:    addi a1, a1, %lo(.LCPI9_0)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lbu a0, 0(a0)
; RV64I-NEXT:    seqz a1, s0
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 31
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret




entry:
  %0 = tail call i32 @llvm.cttz.i32(i32 %x, i1 true)
  %1 = icmp eq i32 %x, 0
  %conv = select i1 %1, i32 0, i32 %0
  ret i32 %conv
}

define signext i32 @globalVar() nounwind {
; RV64ZBB-LABEL: globalVar:
; RV64ZBB:       # %bb.0: # %entry
; RV64ZBB-NEXT:    lui a0, %hi(global_x)
; RV64ZBB-NEXT:    lw a0, %lo(global_x)(a0)
; RV64ZBB-NEXT:    ctzw a0, a0
; RV64ZBB-NEXT:    andi a0, a0, 31
; RV64ZBB-NEXT:    ret
;
; RV32ZBB-LABEL: globalVar:
; RV32ZBB:       # %bb.0: # %entry
; RV32ZBB-NEXT:    lui a0, %hi(global_x)
; RV32ZBB-NEXT:    lw a0, %lo(global_x)(a0)
; RV32ZBB-NEXT:    ctz a0, a0
; RV32ZBB-NEXT:    andi a0, a0, 31
; RV32ZBB-NEXT:    ret
;
; RV32I-LABEL: globalVar:
; RV32I:       # %bb.0: # %entry
; RV32I-NEXT:    addi sp, sp, -16
; RV32I-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32I-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; RV32I-NEXT:    lui a0, %hi(global_x)
; RV32I-NEXT:    lw s0, %lo(global_x)(a0)
; RV32I-NEXT:    neg a0, s0
; RV32I-NEXT:    and a0, s0, a0
; RV32I-NEXT:    lui a1, 30667
; RV32I-NEXT:    addi a1, a1, 1329
; RV32I-NEXT:    call __mulsi3
; RV32I-NEXT:    srli a0, a0, 27
; RV32I-NEXT:    lui a1, %hi(.LCPI10_0)
; RV32I-NEXT:    addi a1, a1, %lo(.LCPI10_0)
; RV32I-NEXT:    add a0, a1, a0
; RV32I-NEXT:    lbu a0, 0(a0)
; RV32I-NEXT:    seqz a1, s0
; RV32I-NEXT:    addi a1, a1, -1
; RV32I-NEXT:    and a0, a0, a1
; RV32I-NEXT:    andi a0, a0, 31
; RV32I-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32I-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; RV32I-NEXT:    addi sp, sp, 16
; RV32I-NEXT:    ret
;
; RV64I-LABEL: globalVar:
; RV64I:       # %bb.0: # %entry
; RV64I-NEXT:    addi sp, sp, -16
; RV64I-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64I-NEXT:    sd s0, 0(sp) # 8-byte Folded Spill
; RV64I-NEXT:    lui a0, %hi(global_x)
; RV64I-NEXT:    lw s0, %lo(global_x)(a0)
; RV64I-NEXT:    neg a0, s0
; RV64I-NEXT:    and a0, s0, a0
; RV64I-NEXT:    lui a1, 30667
; RV64I-NEXT:    addiw a1, a1, 1329
; RV64I-NEXT:    call __muldi3
; RV64I-NEXT:    srliw a0, a0, 27
; RV64I-NEXT:    lui a1, %hi(.LCPI10_0)
; RV64I-NEXT:    addi a1, a1, %lo(.LCPI10_0)
; RV64I-NEXT:    add a0, a1, a0
; RV64I-NEXT:    lbu a0, 0(a0)
; RV64I-NEXT:    seqz a1, s0
; RV64I-NEXT:    addi a1, a1, -1
; RV64I-NEXT:    and a0, a0, a1
; RV64I-NEXT:    andi a0, a0, 31
; RV64I-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64I-NEXT:    ld s0, 0(sp) # 8-byte Folded Reload
; RV64I-NEXT:    addi sp, sp, 16
; RV64I-NEXT:    ret




entry:
  %0 = load i32, i32* @global_x, align 4
  %1 = tail call i32 @llvm.cttz.i32(i32 %0, i1 true)
  %2 = icmp eq i32 %0, 0
  %conv = select i1 %2, i32 0, i32 %1
  ret i32 %conv
}

declare i64 @llvm.cttz.i64(i64, i1 immarg)
declare i32 @llvm.cttz.i32(i32, i1 immarg)
declare i64 @llvm.ctlz.i64(i64, i1 immarg)
