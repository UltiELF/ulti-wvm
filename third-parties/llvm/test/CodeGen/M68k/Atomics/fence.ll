; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=m68k-linux-gnu < %s | FileCheck %s

; M68k's libgcc does NOT have __sync_synchronize so we shouldn't
; lower to that.

define void @atomic_fence() {
; CHECK-LABEL: atomic_fence:
; CHECK:         .cfi_startproc
; CHECK-NEXT:  ; %bb.0: ; %entry
; CHECK-NEXT:    ;APP
; CHECK-NEXT:    ;NO_APP
; CHECK-NEXT:    ;APP
; CHECK-NEXT:    ;NO_APP
; CHECK-NEXT:    ;APP
; CHECK-NEXT:    ;NO_APP
; CHECK-NEXT:    ;APP
; CHECK-NEXT:    ;NO_APP
; CHECK-NEXT:    rts
entry:
  fence acquire
  fence release
  fence acq_rel
  fence seq_cst
  ret void
}

