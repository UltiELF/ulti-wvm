; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc < %s -mtriple=aarch64-none-linux-gnu -global-isel | FileCheck %s
define void @test_oversized(ptr %dst, i32 %cond) {
; CHECK-LABEL: test_oversized:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    stp x29, x30, [sp, #-16]! // 16-byte Folded Spill
; CHECK-NEXT:    mov x29, sp
; CHECK-NEXT:    sub sp, sp, #32
; CHECK-NEXT:    .cfi_def_cfa w29, 16
; CHECK-NEXT:    .cfi_offset w30, -8
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    mov x8, sp
; CHECK-NEXT:    mov x9, #2305843009213693952 // =0x2000000000000000
; CHECK-NEXT:    sub x8, x8, x9
; CHECK-NEXT:    sub x9, x29, #32
; CHECK-NEXT:    mov sp, x8
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    csel x8, x9, x8, eq
; CHECK-NEXT:    str x8, [x0]
; CHECK-NEXT:    mov sp, x29
; CHECK-NEXT:    ldp x29, x30, [sp], #16 // 16-byte Folded Reload
; CHECK-NEXT:    ret
entry:
  %0 = alloca [8 x i32], i32 1, align 4
  %tobool = icmp ne i32 %cond, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:
  %vla1 = alloca [18446744073709551615 x i32], i32 1, align 4
  br label %if.end

if.end:
  %arr = phi ptr [%0, %entry], [%vla1, %if.then]
  store ptr %arr, ptr %dst
  ret void
}
