; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs < %s -mtriple=aarch64-none-linux-gnu | FileCheck %s

define i32 @ori32i32_eq(i32 %x, i32 %y) {
; CHECK-LABEL: ori32i32_eq:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0x1
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    csinc w0, w8, wzr, ne
; CHECK-NEXT:    ret
  %xa = and i32 %x, 1
  %c = icmp eq i32 %y, 0
  %cz = zext i1 %c to i32
  %a = or i32 %xa, %cz
  ret i32 %a
}

define i32 @ori32_eq_c(i32 %x, i32 %y) {
; CHECK-LABEL: ori32_eq_c:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0x1
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    csinc w0, w8, wzr, ne
; CHECK-NEXT:    ret
  %xa = and i32 %x, 1
  %c = icmp eq i32 %y, 0
  %cz = zext i1 %c to i32
  %a = or i32 %cz, %xa
  ret i32 %a
}

define i32 @ori32i64_eq(i32 %x, i64 %y) {
; CHECK-LABEL: ori32i64_eq:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0x1
; CHECK-NEXT:    cmp x1, #0
; CHECK-NEXT:    csinc w0, w8, wzr, ne
; CHECK-NEXT:    ret
  %xa = and i32 %x, 1
  %c = icmp eq i64 %y, 0
  %cz = zext i1 %c to i32
  %a = or i32 %xa, %cz
  ret i32 %a
}

define i32 @ori32_sgt(i32 %x, i32 %y) {
; CHECK-LABEL: ori32_sgt:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w8, w0, #0x1
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    csinc w0, w8, wzr, le
; CHECK-NEXT:    ret
  %xa = and i32 %x, 1
  %c = icmp sgt i32 %y, 0
  %cz = zext i1 %c to i32
  %a = or i32 %xa, %cz
  ret i32 %a
}

; Negative test - too many demanded bits
define i32 @ori32_toomanybits(i32 %x, i32 %y) {
; CHECK-LABEL: ori32_toomanybits:
; CHECK:       // %bb.0:
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    and w8, w0, #0x3
; CHECK-NEXT:    cset w9, eq
; CHECK-NEXT:    orr w0, w8, w9
; CHECK-NEXT:    ret
  %xa = and i32 %x, 3
  %c = icmp eq i32 %y, 0
  %cz = zext i1 %c to i32
  %a = or i32 %xa, %cz
  ret i32 %a
}

define i32 @andi32_ne(i8 %x, i8 %y) {
; CHECK-LABEL: andi32_ne:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0xff
; CHECK-NEXT:    cset w8, eq
; CHECK-NEXT:    tst w1, #0xff
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %xc = icmp eq i8 %x, 0
  %xa = zext i1 %xc to i32
  %c = icmp ne i8 %y, 0
  %cz = zext i1 %c to i32
  %a = and i32 %xa, %cz
  ret i32 %a
}

define i32 @andi32_sgt(i8 %x, i8 %y) {
; CHECK-LABEL: andi32_sgt:
; CHECK:       // %bb.0:
; CHECK-NEXT:    sxtb w8, w1
; CHECK-NEXT:    tst w0, #0xff
; CHECK-NEXT:    ccmp w8, #0, #4, eq
; CHECK-NEXT:    cset w0, gt
; CHECK-NEXT:    ret
  %xc = icmp eq i8 %x, 0
  %xa = zext i1 %xc to i32
  %c = icmp sgt i8 %y, 0
  %cz = zext i1 %c to i32
  %a = and i32 %xa, %cz
  ret i32 %a
}

define i64 @ori64i32_eq(i64 %x, i32 %y) {
; CHECK-LABEL: ori64i32_eq:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and x8, x0, #0x1
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    csinc x0, x8, xzr, ne
; CHECK-NEXT:    ret
  %xa = and i64 %x, 1
  %c = icmp eq i32 %y, 0
  %cz = zext i1 %c to i64
  %a = or i64 %xa, %cz
  ret i64 %a
}

define i64 @ori64i64_eq(i64 %x, i64 %y) {
; CHECK-LABEL: ori64i64_eq:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and x8, x0, #0x1
; CHECK-NEXT:    cmp x1, #0
; CHECK-NEXT:    csinc x0, x8, xzr, ne
; CHECK-NEXT:    ret
  %xa = and i64 %x, 1
  %c = icmp eq i64 %y, 0
  %cz = zext i1 %c to i64
  %a = or i64 %xa, %cz
  ret i64 %a
}

define i64 @ori64_eq_c(i64 %x, i32 %y) {
; CHECK-LABEL: ori64_eq_c:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and x8, x0, #0x1
; CHECK-NEXT:    cmp w1, #0
; CHECK-NEXT:    csinc x0, x8, xzr, ne
; CHECK-NEXT:    ret
  %xa = and i64 %x, 1
  %c = icmp eq i32 %y, 0
  %cz = zext i1 %c to i64
  %a = or i64 %cz, %xa
  ret i64 %a
}

define i64 @andi64_ne(i8 %x, i8 %y) {
; CHECK-LABEL: andi64_ne:
; CHECK:       // %bb.0:
; CHECK-NEXT:    tst w0, #0xff
; CHECK-NEXT:    cset w8, eq
; CHECK-NEXT:    tst w1, #0xff
; CHECK-NEXT:    csel w0, wzr, w8, eq
; CHECK-NEXT:    ret
  %xc = icmp eq i8 %x, 0
  %xa = zext i1 %xc to i64
  %c = icmp ne i8 %y, 0
  %cz = zext i1 %c to i64
  %a = and i64 %xa, %cz
  ret i64 %a
}
