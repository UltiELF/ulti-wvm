; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc -mtriple=aarch64-unknown-linux-gnu -global-isel < %s | FileCheck %s --check-prefixes=CHECK,CHECK-GI

; BIF Bitwise Insert if False
;
; 8-bit vectors tests

define <1 x i8> @test_bitf_v1i8(<1 x i8> %A, <1 x i8> %B, <1 x i8> %C) {
; CHECK-SD-LABEL: test_bitf_v1i8:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_bitf_v1i8:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov x8, d0
; CHECK-GI-NEXT:    fmov x9, d1
; CHECK-GI-NEXT:    fmov x10, d2
; CHECK-GI-NEXT:    bic w9, w9, w10
; CHECK-GI-NEXT:    and w8, w10, w8
; CHECK-GI-NEXT:    orr w8, w9, w8
; CHECK-GI-NEXT:    fmov s0, w8
; CHECK-GI-NEXT:    ret
  %neg = xor <1 x i8> %C, <i8 -1>
  %and = and <1 x i8> %neg, %B
  %and1 = and <1 x i8> %C, %A
  %or = or <1 x i8> %and, %and1
  ret <1 x i8> %or
}

; 16-bit vectors tests

define <1 x i16> @test_bitf_v1i16(<1 x i16> %A, <1 x i16> %B, <1 x i16> %C) {
; CHECK-SD-LABEL: test_bitf_v1i16:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_bitf_v1i16:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov x8, d0
; CHECK-GI-NEXT:    fmov x9, d1
; CHECK-GI-NEXT:    fmov x10, d2
; CHECK-GI-NEXT:    bic w9, w9, w10
; CHECK-GI-NEXT:    and w8, w10, w8
; CHECK-GI-NEXT:    orr w8, w9, w8
; CHECK-GI-NEXT:    fmov s0, w8
; CHECK-GI-NEXT:    ret
  %neg = xor <1 x i16> %C, <i16 -1>
  %and = and <1 x i16> %neg, %B
  %and1 = and <1 x i16> %C, %A
  %or = or <1 x i16> %and, %and1
  ret <1 x i16> %or
}

; 32-bit vectors tests

define <1 x i32> @test_bitf_v1i32(<1 x i32> %A, <1 x i32> %B, <1 x i32> %C) {
; CHECK-SD-LABEL: test_bitf_v1i32:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_bitf_v1i32:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov x8, d0
; CHECK-GI-NEXT:    fmov x9, d1
; CHECK-GI-NEXT:    fmov x10, d2
; CHECK-GI-NEXT:    bic w9, w9, w10
; CHECK-GI-NEXT:    and w8, w10, w8
; CHECK-GI-NEXT:    orr w8, w9, w8
; CHECK-GI-NEXT:    fmov s0, w8
; CHECK-GI-NEXT:    mov v0.s[1], w8
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
  %neg = xor <1 x i32> %C, <i32 -1>
  %and = and <1 x i32> %neg, %B
  %and1 = and <1 x i32> %C, %A
  %or = or <1 x i32> %and, %and1
  ret <1 x i32> %or
}

; 64-bit vectors tests

define <1 x i64> @test_bitf_v1i64(<1 x i64> %A, <1 x i64> %B, <1 x i64> %C) {
; CHECK-SD-LABEL: test_bitf_v1i64:
; CHECK-SD:       // %bb.0:
; CHECK-SD-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: test_bitf_v1i64:
; CHECK-GI:       // %bb.0:
; CHECK-GI-NEXT:    fmov x8, d2
; CHECK-GI-NEXT:    fmov x9, d1
; CHECK-GI-NEXT:    fmov x10, d0
; CHECK-GI-NEXT:    bic x9, x9, x8
; CHECK-GI-NEXT:    and x8, x8, x10
; CHECK-GI-NEXT:    orr x8, x9, x8
; CHECK-GI-NEXT:    fmov d0, x8
; CHECK-GI-NEXT:    ret
  %neg = xor <1 x i64> %C, <i64 -1>
  %and = and <1 x i64> %neg, %B
  %and1 = and <1 x i64> %C, %A
  %or = or <1 x i64> %and, %and1
  ret <1 x i64> %or
}

define <2 x i32> @test_bitf_v2i32(<2 x i32> %A, <2 x i32> %B, <2 x i32> %C) {
; CHECK-LABEL: test_bitf_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %neg = xor <2 x i32> %C, <i32 -1, i32 -1>
  %and = and <2 x i32> %neg, %B
  %and1 = and <2 x i32> %C, %A
  %or = or <2 x i32> %and, %and1
  ret <2 x i32> %or
}

define <4 x i16> @test_bitf_v4i16(<4 x i16> %A, <4 x i16> %B, <4 x i16> %C) {
; CHECK-LABEL: test_bitf_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %neg = xor <4 x i16> %C, <i16 -1, i16 -1, i16 -1, i16 -1>
  %and = and <4 x i16> %neg, %B
  %and1 = and <4 x i16> %C, %A
  %or = or <4 x i16> %and, %and1
  ret <4 x i16> %or
}

define <8 x i8> @test_bitf_v8i8(<8 x i8> %A, <8 x i8> %B, <8 x i8> %C) {
; CHECK-LABEL: test_bitf_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    ret
  %neg = xor <8 x i8> %C, <i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1>
  %and = and <8 x i8> %neg, %B
  %and1 = and <8 x i8> %C, %A
  %or = or <8 x i8> %and, %and1
  ret <8 x i8> %or
}

; 128-bit vectors tests

define <2 x i64> @test_bitf_v2i64(<2 x i64> %A, <2 x i64> %B, <2 x i64> %C) {
; CHECK-LABEL: test_bitf_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
  %neg = xor <2 x i64> %C, <i64 -1, i64 -1>
  %and = and <2 x i64> %neg, %B
  %and1 = and <2 x i64> %C, %A
  %or = or <2 x i64> %and, %and1
  ret <2 x i64> %or
}

define <4 x i32> @test_bitf_v4i32(<4 x i32> %A, <4 x i32> %B, <4 x i32> %C) {
; CHECK-LABEL: test_bitf_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
  %neg = xor <4 x i32> %C, <i32 -1, i32 -1, i32 -1, i32 -1>
  %and = and <4 x i32> %neg, %B
  %and1 = and <4 x i32> %C, %A
  %or = or <4 x i32> %and, %and1
  ret <4 x i32> %or
}

define <8 x i16> @test_bitf_v8i16(<8 x i16> %A, <8 x i16> %B, <8 x i16> %C) {
; CHECK-LABEL: test_bitf_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
  %neg = xor <8 x i16> %C, <i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1, i16 -1>
  %and = and <8 x i16> %neg, %B
  %and1 = and <8 x i16> %C, %A
  %or = or <8 x i16> %and, %and1
  ret <8 x i16> %or
}

define <16 x i8> @test_bitf_v16i8(<16 x i8> %A, <16 x i8> %B, <16 x i8> %C) {
; CHECK-LABEL: test_bitf_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
  %neg = xor <16 x i8> %C, <i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1>
  %and = and <16 x i8> %neg, %B
  %and1 = and <16 x i8> %C, %A
  %or = or <16 x i8> %and, %and1
  ret <16 x i8> %or
}
