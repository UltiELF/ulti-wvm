; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+m -global-isel -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefix=RV64IM

define i64 @sll_i64(i64 %a, i64 %b) {
; RV64IM-LABEL: sll_i64:
; RV64IM:       # %bb.0: # %entry
; RV64IM-NEXT:    sll a0, a0, a1
; RV64IM-NEXT:    ret
entry:
  %0 = shl i64 %a, %b
  ret i64 %0
}

define i64 @slli_i64(i64 %a) {
; RV64IM-LABEL: slli_i64:
; RV64IM:       # %bb.0: # %entry
; RV64IM-NEXT:    slli a0, a0, 33
; RV64IM-NEXT:    ret
entry:
  %0 = shl i64 %a, 33
  ret i64 %0
}

define i64 @sra_i64(i64 %a, i64 %b) {
; RV64IM-LABEL: sra_i64:
; RV64IM:       # %bb.0: # %entry
; RV64IM-NEXT:    sra a0, a0, a1
; RV64IM-NEXT:    ret
entry:
  %0 = ashr i64 %a, %b
  ret i64 %0
}

define i64 @srai_i64(i64 %a) {
; RV64IM-LABEL: srai_i64:
; RV64IM:       # %bb.0: # %entry
; RV64IM-NEXT:    srai a0, a0, 47
; RV64IM-NEXT:    ret
entry:
  %0 = ashr i64 %a, 47
  ret i64 %0
}

define i64 @srl_i64(i64 %a, i64 %b) {
; RV64IM-LABEL: srl_i64:
; RV64IM:       # %bb.0: # %entry
; RV64IM-NEXT:    srl a0, a0, a1
; RV64IM-NEXT:    ret
entry:
  %0 = lshr i64 %a, %b
  ret i64 %0
}

define i64 @srli_i64(i64 %a, i64 %b) {
; RV64IM-LABEL: srli_i64:
; RV64IM:       # %bb.0: # %entry
; RV64IM-NEXT:    srli a0, a0, 55
; RV64IM-NEXT:    ret
entry:
  %0 = lshr i64 %a, 55
  ret i64 %0
}

define i64 @sdiv_i64(i64 %a, i64 %b) {
; RV64IM-LABEL: sdiv_i64:
; RV64IM:       # %bb.0: # %entry
; RV64IM-NEXT:    div a0, a0, a1
; RV64IM-NEXT:    ret
entry:
  %0 = sdiv i64 %a, %b
  ret i64 %0
}

define i64 @srem_i64(i64 %a, i64 %b) {
; RV64IM-LABEL: srem_i64:
; RV64IM:       # %bb.0: # %entry
; RV64IM-NEXT:    rem a0, a0, a1
; RV64IM-NEXT:    ret
entry:
  %0 = srem i64 %a, %b
  ret i64 %0
}

define i64 @udiv_i64(i64 %a, i64 %b) {
; RV64IM-LABEL: udiv_i64:
; RV64IM:       # %bb.0: # %entry
; RV64IM-NEXT:    divu a0, a0, a1
; RV64IM-NEXT:    ret
entry:
  %0 = udiv i64 %a, %b
  ret i64 %0
}

define i64 @urem_i64(i64 %a, i64 %b) {
; RV64IM-LABEL: urem_i64:
; RV64IM:       # %bb.0: # %entry
; RV64IM-NEXT:    remu a0, a0, a1
; RV64IM-NEXT:    ret
entry:
  %0 = urem i64 %a, %b
  ret i64 %0
}
