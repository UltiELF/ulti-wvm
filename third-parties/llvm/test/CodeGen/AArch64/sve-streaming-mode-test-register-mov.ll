; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mattr=+sve -force-streaming-compatible-sve < %s | FileCheck %s
; RUN: llc -mattr=+sme -force-streaming-compatible-sve < %s | FileCheck %s


target triple = "aarch64-unknown-linux-gnu"

; A NEON Q-register mov is not valid in streaming mode, but an SVE Z-register mov is.
define fp128 @test_streaming_compatible_register_mov(fp128 %q0, fp128 %q1) {
; CHECK-LABEL: test_streaming_compatible_register_mov:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, z1.d
; CHECK-NEXT:    ret
  ret fp128 %q1
}

; Test that `movi` isn't used (invalid in streaming mode), but fmov or SVE mov instead.
define double @fp_zero_constant() {
; CHECK-LABEL: fp_zero_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov d0, xzr
; CHECK-NEXT:    ret
  ret double 0.0
}

define <2 x i64> @fixed_vec_zero_constant() {
; CHECK-LABEL: fixed_vec_zero_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, #0 // =0x0
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  ret <2 x i64> zeroinitializer
}

define <2 x double> @fixed_vec_fp_zero_constant() {
; CHECK-LABEL: fixed_vec_fp_zero_constant:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, #0 // =0x0
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  ret <2 x double> <double 0.0, double 0.0>
}
