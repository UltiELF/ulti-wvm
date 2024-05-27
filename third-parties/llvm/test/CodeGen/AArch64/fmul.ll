; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=aarch64-none-eabi -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD,CHECK-SD-NOFP16
; RUN: llc -mtriple=aarch64-none-eabi -mattr=+fullfp16 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD,CHECK-SD-FP16
; RUN: llc -mtriple=aarch64-none-eabi -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI,CHECK-GI-NOFP16
; RUN: llc -mtriple=aarch64-none-eabi -mattr=+fullfp16 -global-isel -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI,CHECK-GI-FP16

define double @fmul_f64(double %a, double %b) {
; CHECK-LABEL: fmul_f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul d0, d0, d1
; CHECK-NEXT:    ret
entry:
  %c = fmul double %a, %b
  ret double %c
}

define float @fmul_f32(float %a, float %b) {
; CHECK-LABEL: fmul_f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul s0, s0, s1
; CHECK-NEXT:    ret
entry:
  %c = fmul float %a, %b
  ret float %c
}

define half @fmul_f16(half %a, half %b) {
; CHECK-SD-NOFP16-LABEL: fmul_f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvt s1, h1
; CHECK-SD-NOFP16-NEXT:    fcvt s0, h0
; CHECK-SD-NOFP16-NEXT:    fmul s0, s0, s1
; CHECK-SD-NOFP16-NEXT:    fcvt h0, s0
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fmul_f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fmul h0, h0, h1
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fmul_f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvt s0, h0
; CHECK-GI-NOFP16-NEXT:    fcvt s1, h1
; CHECK-GI-NOFP16-NEXT:    fmul s0, s0, s1
; CHECK-GI-NOFP16-NEXT:    fcvt h0, s0
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fmul_f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fmul h0, h0, h1
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fmul half %a, %b
  ret half %c
}

define <2 x double> @fmul_v2f64(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: fmul_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul v0.2d, v0.2d, v1.2d
; CHECK-NEXT:    ret
entry:
  %c = fmul <2 x double> %a, %b
  ret <2 x double> %c
}

define <3 x double> @fmul_v3f64(<3 x double> %a, <3 x double> %b) {
; CHECK-SD-LABEL: fmul_v3f64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    // kill: def $d3 killed $d3 def $q3
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-SD-NEXT:    // kill: def $d4 killed $d4 def $q4
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-SD-NEXT:    // kill: def $d2 killed $d2 def $q2
; CHECK-SD-NEXT:    // kill: def $d5 killed $d5 def $q5
; CHECK-SD-NEXT:    mov v3.d[1], v4.d[0]
; CHECK-SD-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-SD-NEXT:    fmul v2.2d, v2.2d, v5.2d
; CHECK-SD-NEXT:    // kill: def $d2 killed $d2 killed $q2
; CHECK-SD-NEXT:    fmul v0.2d, v0.2d, v3.2d
; CHECK-SD-NEXT:    ext v1.16b, v0.16b, v0.16b, #8
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 killed $q1
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fmul_v3f64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-GI-NEXT:    // kill: def $d3 killed $d3 def $q3
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-GI-NEXT:    // kill: def $d4 killed $d4 def $q4
; CHECK-GI-NEXT:    fmul d2, d2, d5
; CHECK-GI-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-GI-NEXT:    mov v3.d[1], v4.d[0]
; CHECK-GI-NEXT:    fmul v0.2d, v0.2d, v3.2d
; CHECK-GI-NEXT:    mov d1, v0.d[1]
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %c = fmul <3 x double> %a, %b
  ret <3 x double> %c
}

define <4 x double> @fmul_v4f64(<4 x double> %a, <4 x double> %b) {
; CHECK-SD-LABEL: fmul_v4f64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    fmul v1.2d, v1.2d, v3.2d
; CHECK-SD-NEXT:    fmul v0.2d, v0.2d, v2.2d
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fmul_v4f64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    fmul v0.2d, v0.2d, v2.2d
; CHECK-GI-NEXT:    fmul v1.2d, v1.2d, v3.2d
; CHECK-GI-NEXT:    ret
entry:
  %c = fmul <4 x double> %a, %b
  ret <4 x double> %c
}

define <2 x float> @fmul_v2f32(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: fmul_v2f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEXT:    ret
entry:
  %c = fmul <2 x float> %a, %b
  ret <2 x float> %c
}

define <3 x float> @fmul_v3f32(<3 x float> %a, <3 x float> %b) {
; CHECK-LABEL: fmul_v3f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %c = fmul <3 x float> %a, %b
  ret <3 x float> %c
}

define <4 x float> @fmul_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: fmul_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-NEXT:    ret
entry:
  %c = fmul <4 x float> %a, %b
  ret <4 x float> %c
}

define <8 x float> @fmul_v8f32(<8 x float> %a, <8 x float> %b) {
; CHECK-SD-LABEL: fmul_v8f32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    fmul v1.4s, v1.4s, v3.4s
; CHECK-SD-NEXT:    fmul v0.4s, v0.4s, v2.4s
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: fmul_v8f32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    fmul v0.4s, v0.4s, v2.4s
; CHECK-GI-NEXT:    fmul v1.4s, v1.4s, v3.4s
; CHECK-GI-NEXT:    ret
entry:
  %c = fmul <8 x float> %a, %b
  ret <8 x float> %c
}

define <7 x half> @fmul_v7f16(<7 x half> %a, <7 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fmul_v7f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    mov h2, v1.h[1]
; CHECK-SD-NOFP16-NEXT:    mov h3, v0.h[1]
; CHECK-SD-NOFP16-NEXT:    fcvt s4, h1
; CHECK-SD-NOFP16-NEXT:    fcvt s5, h0
; CHECK-SD-NOFP16-NEXT:    mov h6, v1.h[2]
; CHECK-SD-NOFP16-NEXT:    mov h7, v0.h[2]
; CHECK-SD-NOFP16-NEXT:    mov h16, v1.h[3]
; CHECK-SD-NOFP16-NEXT:    fcvt s2, h2
; CHECK-SD-NOFP16-NEXT:    fcvt s3, h3
; CHECK-SD-NOFP16-NEXT:    fmul s4, s5, s4
; CHECK-SD-NOFP16-NEXT:    mov h5, v0.h[3]
; CHECK-SD-NOFP16-NEXT:    fcvt s6, h6
; CHECK-SD-NOFP16-NEXT:    fcvt s7, h7
; CHECK-SD-NOFP16-NEXT:    fcvt s16, h16
; CHECK-SD-NOFP16-NEXT:    fmul s3, s3, s2
; CHECK-SD-NOFP16-NEXT:    fcvt s5, h5
; CHECK-SD-NOFP16-NEXT:    fcvt h2, s4
; CHECK-SD-NOFP16-NEXT:    fmul s4, s7, s6
; CHECK-SD-NOFP16-NEXT:    mov h6, v1.h[4]
; CHECK-SD-NOFP16-NEXT:    mov h7, v0.h[4]
; CHECK-SD-NOFP16-NEXT:    fcvt h3, s3
; CHECK-SD-NOFP16-NEXT:    fmul s5, s5, s16
; CHECK-SD-NOFP16-NEXT:    mov h16, v0.h[5]
; CHECK-SD-NOFP16-NEXT:    fcvt h4, s4
; CHECK-SD-NOFP16-NEXT:    mov v2.h[1], v3.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt s3, h6
; CHECK-SD-NOFP16-NEXT:    fcvt s6, h7
; CHECK-SD-NOFP16-NEXT:    mov h7, v1.h[5]
; CHECK-SD-NOFP16-NEXT:    fcvt h5, s5
; CHECK-SD-NOFP16-NEXT:    fcvt s16, h16
; CHECK-SD-NOFP16-NEXT:    mov v2.h[2], v4.h[0]
; CHECK-SD-NOFP16-NEXT:    mov h4, v1.h[6]
; CHECK-SD-NOFP16-NEXT:    fmul s3, s6, s3
; CHECK-SD-NOFP16-NEXT:    mov h6, v0.h[6]
; CHECK-SD-NOFP16-NEXT:    fcvt s7, h7
; CHECK-SD-NOFP16-NEXT:    mov h1, v1.h[7]
; CHECK-SD-NOFP16-NEXT:    mov h0, v0.h[7]
; CHECK-SD-NOFP16-NEXT:    mov v2.h[3], v5.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt s4, h4
; CHECK-SD-NOFP16-NEXT:    fcvt h3, s3
; CHECK-SD-NOFP16-NEXT:    fcvt s5, h6
; CHECK-SD-NOFP16-NEXT:    fmul s6, s16, s7
; CHECK-SD-NOFP16-NEXT:    fcvt s1, h1
; CHECK-SD-NOFP16-NEXT:    fcvt s0, h0
; CHECK-SD-NOFP16-NEXT:    mov v2.h[4], v3.h[0]
; CHECK-SD-NOFP16-NEXT:    fmul s4, s5, s4
; CHECK-SD-NOFP16-NEXT:    fcvt h3, s6
; CHECK-SD-NOFP16-NEXT:    fmul s0, s0, s1
; CHECK-SD-NOFP16-NEXT:    mov v2.h[5], v3.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt h3, s4
; CHECK-SD-NOFP16-NEXT:    fcvt h0, s0
; CHECK-SD-NOFP16-NEXT:    mov v2.h[6], v3.h[0]
; CHECK-SD-NOFP16-NEXT:    mov v2.h[7], v0.h[0]
; CHECK-SD-NOFP16-NEXT:    mov v0.16b, v2.16b
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fmul_v7f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fmul v0.8h, v0.8h, v1.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fmul_v7f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    mov h2, v0.h[4]
; CHECK-GI-NOFP16-NEXT:    mov h3, v0.h[5]
; CHECK-GI-NOFP16-NEXT:    mov h4, v1.h[4]
; CHECK-GI-NOFP16-NEXT:    mov h5, v1.h[5]
; CHECK-GI-NOFP16-NEXT:    fcvtl v6.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v7.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    mov h0, v0.h[6]
; CHECK-GI-NOFP16-NEXT:    mov h1, v1.h[6]
; CHECK-GI-NOFP16-NEXT:    mov v2.h[1], v3.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v4.h[1], v5.h[0]
; CHECK-GI-NOFP16-NEXT:    fmul v3.4s, v6.4s, v7.4s
; CHECK-GI-NOFP16-NEXT:    mov v2.h[2], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v4.h[2], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v3.4s
; CHECK-GI-NOFP16-NEXT:    mov v2.h[3], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v4.h[3], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h1, v0.h[1]
; CHECK-GI-NOFP16-NEXT:    mov h5, v0.h[3]
; CHECK-GI-NOFP16-NEXT:    fcvtl v2.4s, v2.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v3.4s, v4.4h
; CHECK-GI-NOFP16-NEXT:    mov h4, v0.h[2]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[1], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    fmul v1.4s, v2.4s, v3.4s
; CHECK-GI-NOFP16-NEXT:    mov v0.h[2], v4.h[0]
; CHECK-GI-NOFP16-NEXT:    fcvtn v1.4h, v1.4s
; CHECK-GI-NOFP16-NEXT:    mov v0.h[3], v5.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h2, v1.h[1]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[4], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    mov h1, v1.h[2]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[5], v2.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[6], v1.h[0]
; CHECK-GI-NOFP16-NEXT:    mov v0.h[7], v0.h[0]
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fmul_v7f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fmul v0.8h, v0.8h, v1.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fmul <7 x half> %a, %b
  ret <7 x half> %c
}

define <4 x half> @fmul_v4f16(<4 x half> %a, <4 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fmul_v4f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    fcvtl v1.4s, v1.4h
; CHECK-SD-NOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-SD-NOFP16-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-SD-NOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fmul_v4f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fmul v0.4h, v0.4h, v1.4h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fmul_v4f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v0.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v1.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v0.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fmul_v4f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fmul v0.4h, v0.4h, v1.4h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fmul <4 x half> %a, %b
  ret <4 x half> %c
}

define <8 x half> @fmul_v8f16(<8 x half> %a, <8 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fmul_v8f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    mov h2, v1.h[1]
; CHECK-SD-NOFP16-NEXT:    mov h3, v0.h[1]
; CHECK-SD-NOFP16-NEXT:    fcvt s4, h1
; CHECK-SD-NOFP16-NEXT:    fcvt s5, h0
; CHECK-SD-NOFP16-NEXT:    mov h6, v1.h[2]
; CHECK-SD-NOFP16-NEXT:    mov h7, v0.h[2]
; CHECK-SD-NOFP16-NEXT:    mov h16, v1.h[3]
; CHECK-SD-NOFP16-NEXT:    fcvt s2, h2
; CHECK-SD-NOFP16-NEXT:    fcvt s3, h3
; CHECK-SD-NOFP16-NEXT:    fmul s4, s5, s4
; CHECK-SD-NOFP16-NEXT:    mov h5, v0.h[3]
; CHECK-SD-NOFP16-NEXT:    fcvt s6, h6
; CHECK-SD-NOFP16-NEXT:    fcvt s7, h7
; CHECK-SD-NOFP16-NEXT:    fcvt s16, h16
; CHECK-SD-NOFP16-NEXT:    fmul s3, s3, s2
; CHECK-SD-NOFP16-NEXT:    fcvt s5, h5
; CHECK-SD-NOFP16-NEXT:    fcvt h2, s4
; CHECK-SD-NOFP16-NEXT:    fmul s4, s7, s6
; CHECK-SD-NOFP16-NEXT:    mov h6, v1.h[4]
; CHECK-SD-NOFP16-NEXT:    mov h7, v0.h[4]
; CHECK-SD-NOFP16-NEXT:    fcvt h3, s3
; CHECK-SD-NOFP16-NEXT:    fmul s5, s5, s16
; CHECK-SD-NOFP16-NEXT:    mov h16, v0.h[5]
; CHECK-SD-NOFP16-NEXT:    fcvt h4, s4
; CHECK-SD-NOFP16-NEXT:    mov v2.h[1], v3.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt s3, h6
; CHECK-SD-NOFP16-NEXT:    fcvt s6, h7
; CHECK-SD-NOFP16-NEXT:    mov h7, v1.h[5]
; CHECK-SD-NOFP16-NEXT:    fcvt h5, s5
; CHECK-SD-NOFP16-NEXT:    fcvt s16, h16
; CHECK-SD-NOFP16-NEXT:    mov v2.h[2], v4.h[0]
; CHECK-SD-NOFP16-NEXT:    mov h4, v1.h[6]
; CHECK-SD-NOFP16-NEXT:    fmul s3, s6, s3
; CHECK-SD-NOFP16-NEXT:    mov h6, v0.h[6]
; CHECK-SD-NOFP16-NEXT:    fcvt s7, h7
; CHECK-SD-NOFP16-NEXT:    mov h1, v1.h[7]
; CHECK-SD-NOFP16-NEXT:    mov h0, v0.h[7]
; CHECK-SD-NOFP16-NEXT:    mov v2.h[3], v5.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt s4, h4
; CHECK-SD-NOFP16-NEXT:    fcvt h3, s3
; CHECK-SD-NOFP16-NEXT:    fcvt s5, h6
; CHECK-SD-NOFP16-NEXT:    fmul s6, s16, s7
; CHECK-SD-NOFP16-NEXT:    fcvt s1, h1
; CHECK-SD-NOFP16-NEXT:    fcvt s0, h0
; CHECK-SD-NOFP16-NEXT:    mov v2.h[4], v3.h[0]
; CHECK-SD-NOFP16-NEXT:    fmul s4, s5, s4
; CHECK-SD-NOFP16-NEXT:    fcvt h3, s6
; CHECK-SD-NOFP16-NEXT:    fmul s0, s0, s1
; CHECK-SD-NOFP16-NEXT:    mov v2.h[5], v3.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt h3, s4
; CHECK-SD-NOFP16-NEXT:    fcvt h0, s0
; CHECK-SD-NOFP16-NEXT:    mov v2.h[6], v3.h[0]
; CHECK-SD-NOFP16-NEXT:    mov v2.h[7], v0.h[0]
; CHECK-SD-NOFP16-NEXT:    mov v0.16b, v2.16b
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fmul_v8f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fmul v0.8h, v0.8h, v1.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fmul_v8f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v2.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v3.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-GI-NOFP16-NEXT:    fmul v2.4s, v2.4s, v3.4s
; CHECK-GI-NOFP16-NEXT:    fmul v1.4s, v0.4s, v1.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v2.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v0.8h, v1.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fmul_v8f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fmul v0.8h, v0.8h, v1.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fmul <8 x half> %a, %b
  ret <8 x half> %c
}

define <16 x half> @fmul_v16f16(<16 x half> %a, <16 x half> %b) {
; CHECK-SD-NOFP16-LABEL: fmul_v16f16:
; CHECK-SD-NOFP16:       // %bb.0: // %entry
; CHECK-SD-NOFP16-NEXT:    mov h4, v2.h[1]
; CHECK-SD-NOFP16-NEXT:    mov h5, v0.h[1]
; CHECK-SD-NOFP16-NEXT:    mov h6, v3.h[1]
; CHECK-SD-NOFP16-NEXT:    mov h7, v1.h[1]
; CHECK-SD-NOFP16-NEXT:    fcvt s16, h2
; CHECK-SD-NOFP16-NEXT:    fcvt s17, h0
; CHECK-SD-NOFP16-NEXT:    mov h18, v2.h[2]
; CHECK-SD-NOFP16-NEXT:    mov h19, v0.h[2]
; CHECK-SD-NOFP16-NEXT:    fcvt s20, h3
; CHECK-SD-NOFP16-NEXT:    fcvt s21, h1
; CHECK-SD-NOFP16-NEXT:    mov h22, v3.h[2]
; CHECK-SD-NOFP16-NEXT:    mov h23, v1.h[2]
; CHECK-SD-NOFP16-NEXT:    fcvt s4, h4
; CHECK-SD-NOFP16-NEXT:    fcvt s5, h5
; CHECK-SD-NOFP16-NEXT:    fcvt s6, h6
; CHECK-SD-NOFP16-NEXT:    fmul s16, s17, s16
; CHECK-SD-NOFP16-NEXT:    fcvt s7, h7
; CHECK-SD-NOFP16-NEXT:    mov h24, v0.h[3]
; CHECK-SD-NOFP16-NEXT:    fcvt s17, h18
; CHECK-SD-NOFP16-NEXT:    fcvt s18, h19
; CHECK-SD-NOFP16-NEXT:    mov h19, v2.h[3]
; CHECK-SD-NOFP16-NEXT:    fmul s20, s21, s20
; CHECK-SD-NOFP16-NEXT:    fcvt s21, h22
; CHECK-SD-NOFP16-NEXT:    fcvt s22, h23
; CHECK-SD-NOFP16-NEXT:    fmul s5, s5, s4
; CHECK-SD-NOFP16-NEXT:    mov h23, v1.h[3]
; CHECK-SD-NOFP16-NEXT:    mov h25, v1.h[6]
; CHECK-SD-NOFP16-NEXT:    fmul s6, s7, s6
; CHECK-SD-NOFP16-NEXT:    mov h7, v3.h[3]
; CHECK-SD-NOFP16-NEXT:    fcvt s24, h24
; CHECK-SD-NOFP16-NEXT:    fmul s17, s18, s17
; CHECK-SD-NOFP16-NEXT:    fcvt s19, h19
; CHECK-SD-NOFP16-NEXT:    fcvt h4, s16
; CHECK-SD-NOFP16-NEXT:    fmul s18, s22, s21
; CHECK-SD-NOFP16-NEXT:    mov h22, v0.h[4]
; CHECK-SD-NOFP16-NEXT:    fcvt h16, s5
; CHECK-SD-NOFP16-NEXT:    fcvt h5, s20
; CHECK-SD-NOFP16-NEXT:    fcvt s21, h23
; CHECK-SD-NOFP16-NEXT:    fcvt h6, s6
; CHECK-SD-NOFP16-NEXT:    fcvt s7, h7
; CHECK-SD-NOFP16-NEXT:    mov h20, v2.h[4]
; CHECK-SD-NOFP16-NEXT:    fmul s19, s24, s19
; CHECK-SD-NOFP16-NEXT:    fcvt h17, s17
; CHECK-SD-NOFP16-NEXT:    mov h23, v1.h[4]
; CHECK-SD-NOFP16-NEXT:    mov h24, v0.h[6]
; CHECK-SD-NOFP16-NEXT:    mov v4.h[1], v16.h[0]
; CHECK-SD-NOFP16-NEXT:    mov h16, v3.h[4]
; CHECK-SD-NOFP16-NEXT:    fmul s7, s21, s7
; CHECK-SD-NOFP16-NEXT:    mov v5.h[1], v6.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt h6, s18
; CHECK-SD-NOFP16-NEXT:    fcvt s18, h20
; CHECK-SD-NOFP16-NEXT:    fcvt h19, s19
; CHECK-SD-NOFP16-NEXT:    fcvt s20, h22
; CHECK-SD-NOFP16-NEXT:    mov h21, v2.h[5]
; CHECK-SD-NOFP16-NEXT:    mov h22, v0.h[5]
; CHECK-SD-NOFP16-NEXT:    mov h0, v0.h[7]
; CHECK-SD-NOFP16-NEXT:    mov v4.h[2], v17.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt s16, h16
; CHECK-SD-NOFP16-NEXT:    fcvt s17, h23
; CHECK-SD-NOFP16-NEXT:    mov v5.h[2], v6.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt h6, s7
; CHECK-SD-NOFP16-NEXT:    mov h7, v3.h[5]
; CHECK-SD-NOFP16-NEXT:    fmul s18, s20, s18
; CHECK-SD-NOFP16-NEXT:    mov h23, v1.h[5]
; CHECK-SD-NOFP16-NEXT:    mov h20, v2.h[6]
; CHECK-SD-NOFP16-NEXT:    mov h2, v2.h[7]
; CHECK-SD-NOFP16-NEXT:    mov h1, v1.h[7]
; CHECK-SD-NOFP16-NEXT:    fcvt s0, h0
; CHECK-SD-NOFP16-NEXT:    fmul s16, s17, s16
; CHECK-SD-NOFP16-NEXT:    mov h17, v3.h[6]
; CHECK-SD-NOFP16-NEXT:    mov v4.h[3], v19.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt s19, h21
; CHECK-SD-NOFP16-NEXT:    fcvt s21, h22
; CHECK-SD-NOFP16-NEXT:    mov v5.h[3], v6.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt s6, h7
; CHECK-SD-NOFP16-NEXT:    fcvt s7, h23
; CHECK-SD-NOFP16-NEXT:    fcvt h18, s18
; CHECK-SD-NOFP16-NEXT:    fcvt s20, h20
; CHECK-SD-NOFP16-NEXT:    fcvt s22, h24
; CHECK-SD-NOFP16-NEXT:    fcvt s23, h25
; CHECK-SD-NOFP16-NEXT:    fcvt h16, s16
; CHECK-SD-NOFP16-NEXT:    fcvt s17, h17
; CHECK-SD-NOFP16-NEXT:    mov h3, v3.h[7]
; CHECK-SD-NOFP16-NEXT:    fmul s19, s21, s19
; CHECK-SD-NOFP16-NEXT:    fcvt s2, h2
; CHECK-SD-NOFP16-NEXT:    fcvt s1, h1
; CHECK-SD-NOFP16-NEXT:    fmul s6, s7, s6
; CHECK-SD-NOFP16-NEXT:    mov v4.h[4], v18.h[0]
; CHECK-SD-NOFP16-NEXT:    fmul s7, s22, s20
; CHECK-SD-NOFP16-NEXT:    mov v5.h[4], v16.h[0]
; CHECK-SD-NOFP16-NEXT:    fmul s16, s23, s17
; CHECK-SD-NOFP16-NEXT:    fcvt s3, h3
; CHECK-SD-NOFP16-NEXT:    fmul s0, s0, s2
; CHECK-SD-NOFP16-NEXT:    fcvt h17, s19
; CHECK-SD-NOFP16-NEXT:    fcvt h6, s6
; CHECK-SD-NOFP16-NEXT:    fcvt h2, s7
; CHECK-SD-NOFP16-NEXT:    fmul s1, s1, s3
; CHECK-SD-NOFP16-NEXT:    mov v4.h[5], v17.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt h0, s0
; CHECK-SD-NOFP16-NEXT:    mov v5.h[5], v6.h[0]
; CHECK-SD-NOFP16-NEXT:    fcvt h6, s16
; CHECK-SD-NOFP16-NEXT:    fcvt h1, s1
; CHECK-SD-NOFP16-NEXT:    mov v4.h[6], v2.h[0]
; CHECK-SD-NOFP16-NEXT:    mov v5.h[6], v6.h[0]
; CHECK-SD-NOFP16-NEXT:    mov v4.h[7], v0.h[0]
; CHECK-SD-NOFP16-NEXT:    mov v5.h[7], v1.h[0]
; CHECK-SD-NOFP16-NEXT:    mov v0.16b, v4.16b
; CHECK-SD-NOFP16-NEXT:    mov v1.16b, v5.16b
; CHECK-SD-NOFP16-NEXT:    ret
;
; CHECK-SD-FP16-LABEL: fmul_v16f16:
; CHECK-SD-FP16:       // %bb.0: // %entry
; CHECK-SD-FP16-NEXT:    fmul v1.8h, v1.8h, v3.8h
; CHECK-SD-FP16-NEXT:    fmul v0.8h, v0.8h, v2.8h
; CHECK-SD-FP16-NEXT:    ret
;
; CHECK-GI-NOFP16-LABEL: fmul_v16f16:
; CHECK-GI-NOFP16:       // %bb.0: // %entry
; CHECK-GI-NOFP16-NEXT:    fcvtl v4.4s, v0.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v5.4s, v1.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v6.4s, v2.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl v7.4s, v3.4h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v0.4s, v0.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v1.4s, v1.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v2.4s, v2.8h
; CHECK-GI-NOFP16-NEXT:    fcvtl2 v3.4s, v3.8h
; CHECK-GI-NOFP16-NEXT:    fmul v4.4s, v4.4s, v6.4s
; CHECK-GI-NOFP16-NEXT:    fmul v5.4s, v5.4s, v7.4s
; CHECK-GI-NOFP16-NEXT:    fmul v2.4s, v0.4s, v2.4s
; CHECK-GI-NOFP16-NEXT:    fmul v3.4s, v1.4s, v3.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v0.4h, v4.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn v1.4h, v5.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v0.8h, v2.4s
; CHECK-GI-NOFP16-NEXT:    fcvtn2 v1.8h, v3.4s
; CHECK-GI-NOFP16-NEXT:    ret
;
; CHECK-GI-FP16-LABEL: fmul_v16f16:
; CHECK-GI-FP16:       // %bb.0: // %entry
; CHECK-GI-FP16-NEXT:    fmul v0.8h, v0.8h, v2.8h
; CHECK-GI-FP16-NEXT:    fmul v1.8h, v1.8h, v3.8h
; CHECK-GI-FP16-NEXT:    ret
entry:
  %c = fmul <16 x half> %a, %b
  ret <16 x half> %c
}

