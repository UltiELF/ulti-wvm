; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc -mtriple=aarch64-none-eabi -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-SD
; RUN: llc -mtriple=aarch64-none-eabi -global-isel -global-isel-abort=2 -verify-machineinstrs %s -o - | FileCheck %s --check-prefixes=CHECK,CHECK-GI

define double @copysign_f64(double %a, double %b) {
; CHECK-SD-LABEL: copysign_f64:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    movi v2.2d, #0xffffffffffffffff
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-SD-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-SD-NEXT:    fneg v2.2d, v2.2d
; CHECK-SD-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-SD-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: copysign_f64:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    movi v2.2d, #0000000000000000
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-GI-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-GI-NEXT:    mov v0.d[0], v0.d[0]
; CHECK-GI-NEXT:    mov v1.d[0], v1.d[0]
; CHECK-GI-NEXT:    fneg v2.2d, v2.2d
; CHECK-GI-NEXT:    bit v0.16b, v1.16b, v2.16b
; CHECK-GI-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %c = call double @llvm.copysign.f64(double %a, double %b)
  ret double %c
}

define float @copysign_f32(float %a, float %b) {
; CHECK-SD-LABEL: copysign_f32:
; CHECK-SD:       // %bb.0: // %entry
; CHECK-SD-NEXT:    mvni v2.4s, #128, lsl #24
; CHECK-SD-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-SD-NEXT:    // kill: def $s1 killed $s1 def $q1
; CHECK-SD-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-SD-NEXT:    // kill: def $s0 killed $s0 killed $q0
; CHECK-SD-NEXT:    ret
;
; CHECK-GI-LABEL: copysign_f32:
; CHECK-GI:       // %bb.0: // %entry
; CHECK-GI-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-GI-NEXT:    // kill: def $s1 killed $s1 def $q1
; CHECK-GI-NEXT:    movi v2.4s, #128, lsl #24
; CHECK-GI-NEXT:    mov v0.s[0], v0.s[0]
; CHECK-GI-NEXT:    mov v1.s[0], v1.s[0]
; CHECK-GI-NEXT:    bit v0.16b, v1.16b, v2.16b
; CHECK-GI-NEXT:    // kill: def $s0 killed $s0 killed $q0
; CHECK-GI-NEXT:    ret
entry:
  %c = call float @llvm.copysign.f32(float %a, float %b)
  ret float %c
}

define half @copysign_f16(half %a, half %b) {
; CHECK-LABEL: copysign_f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    fcvt s1, h1
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    mvni v2.4s, #128, lsl #24
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    fcvt h0, s0
; CHECK-NEXT:    ret
entry:
  %c = call half @llvm.copysign.f16(half %a, half %b)
  ret half %c
}

define <2 x double> @copysign_v2f64(<2 x double> %a, <2 x double> %b) {
; CHECK-LABEL: copysign_v2f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v2.2d, #0xffffffffffffffff
; CHECK-NEXT:    fneg v2.2d, v2.2d
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %c = call <2 x double> @llvm.copysign.v2f64(<2 x double> %a, <2 x double> %b)
  ret <2 x double> %c
}

define <3 x double> @copysign_v3f64(<3 x double> %a, <3 x double> %b) {
; CHECK-LABEL: copysign_v3f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v6.2d, #0xffffffffffffffff
; CHECK-NEXT:    // kill: def $d3 killed $d3 def $q3
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    // kill: def $d4 killed $d4 def $q4
; CHECK-NEXT:    // kill: def $d2 killed $d2 def $q2
; CHECK-NEXT:    // kill: def $d5 killed $d5 def $q5
; CHECK-NEXT:    mov v3.d[1], v4.d[0]
; CHECK-NEXT:    mov v0.d[1], v1.d[0]
; CHECK-NEXT:    fneg v1.2d, v6.2d
; CHECK-NEXT:    bif v0.16b, v3.16b, v1.16b
; CHECK-NEXT:    bif v2.16b, v5.16b, v1.16b
; CHECK-NEXT:    // kill: def $d2 killed $d2 killed $q2
; CHECK-NEXT:    ext v1.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    // kill: def $d1 killed $d1 killed $q1
; CHECK-NEXT:    ret
entry:
  %c = call <3 x double> @llvm.copysign.v3f64(<3 x double> %a, <3 x double> %b)
  ret <3 x double> %c
}

define <4 x double> @copysign_v4f64(<4 x double> %a, <4 x double> %b) {
; CHECK-LABEL: copysign_v4f64:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    movi v4.2d, #0xffffffffffffffff
; CHECK-NEXT:    fneg v4.2d, v4.2d
; CHECK-NEXT:    bif v0.16b, v2.16b, v4.16b
; CHECK-NEXT:    bif v1.16b, v3.16b, v4.16b
; CHECK-NEXT:    ret
entry:
  %c = call <4 x double> @llvm.copysign.v4f64(<4 x double> %a, <4 x double> %b)
  ret <4 x double> %c
}

define <2 x float> @copysign_v2f32(<2 x float> %a, <2 x float> %b) {
; CHECK-LABEL: copysign_v2f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mvni v2.2s, #128, lsl #24
; CHECK-NEXT:    bif v0.8b, v1.8b, v2.8b
; CHECK-NEXT:    ret
entry:
  %c = call <2 x float> @llvm.copysign.v2f32(<2 x float> %a, <2 x float> %b)
  ret <2 x float> %c
}

define <3 x float> @copysign_v3f32(<3 x float> %a, <3 x float> %b) {
; CHECK-LABEL: copysign_v3f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mvni v2.4s, #128, lsl #24
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %c = call <3 x float> @llvm.copysign.v3f32(<3 x float> %a, <3 x float> %b)
  ret <3 x float> %c
}

define <4 x float> @copysign_v4f32(<4 x float> %a, <4 x float> %b) {
; CHECK-LABEL: copysign_v4f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mvni v2.4s, #128, lsl #24
; CHECK-NEXT:    bif v0.16b, v1.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %c = call <4 x float> @llvm.copysign.v4f32(<4 x float> %a, <4 x float> %b)
  ret <4 x float> %c
}

define <8 x float> @copysign_v8f32(<8 x float> %a, <8 x float> %b) {
; CHECK-LABEL: copysign_v8f32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mvni v4.4s, #128, lsl #24
; CHECK-NEXT:    bif v0.16b, v2.16b, v4.16b
; CHECK-NEXT:    bif v1.16b, v3.16b, v4.16b
; CHECK-NEXT:    ret
entry:
  %c = call <8 x float> @llvm.copysign.v8f32(<8 x float> %a, <8 x float> %b)
  ret <8 x float> %c
}

define <7 x half> @copysign_v7f16(<7 x half> %a, <7 x half> %b) {
; CHECK-LABEL: copysign_v7f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov h2, v1.h[1]
; CHECK-NEXT:    mov h4, v0.h[1]
; CHECK-NEXT:    fcvt s5, h1
; CHECK-NEXT:    fcvt s6, h0
; CHECK-NEXT:    mvni v3.4s, #128, lsl #24
; CHECK-NEXT:    mov h7, v1.h[2]
; CHECK-NEXT:    mov h16, v0.h[2]
; CHECK-NEXT:    mov h17, v1.h[3]
; CHECK-NEXT:    fcvt s2, h2
; CHECK-NEXT:    fcvt s4, h4
; CHECK-NEXT:    bit v5.16b, v6.16b, v3.16b
; CHECK-NEXT:    mov h6, v0.h[3]
; CHECK-NEXT:    fcvt s7, h7
; CHECK-NEXT:    fcvt s16, h16
; CHECK-NEXT:    fcvt s17, h17
; CHECK-NEXT:    bif v4.16b, v2.16b, v3.16b
; CHECK-NEXT:    fcvt h2, s5
; CHECK-NEXT:    mov v5.16b, v3.16b
; CHECK-NEXT:    fcvt s6, h6
; CHECK-NEXT:    bsl v5.16b, v16.16b, v7.16b
; CHECK-NEXT:    fcvt h4, s4
; CHECK-NEXT:    mov h7, v1.h[4]
; CHECK-NEXT:    mov h16, v0.h[4]
; CHECK-NEXT:    bif v6.16b, v17.16b, v3.16b
; CHECK-NEXT:    mov h17, v0.h[5]
; CHECK-NEXT:    fcvt h5, s5
; CHECK-NEXT:    mov v2.h[1], v4.h[0]
; CHECK-NEXT:    fcvt s4, h7
; CHECK-NEXT:    fcvt s7, h16
; CHECK-NEXT:    mov h16, v1.h[5]
; CHECK-NEXT:    fcvt h6, s6
; CHECK-NEXT:    fcvt s17, h17
; CHECK-NEXT:    mov v2.h[2], v5.h[0]
; CHECK-NEXT:    mov h5, v1.h[6]
; CHECK-NEXT:    mov h1, v1.h[7]
; CHECK-NEXT:    bit v4.16b, v7.16b, v3.16b
; CHECK-NEXT:    mov h7, v0.h[6]
; CHECK-NEXT:    fcvt s16, h16
; CHECK-NEXT:    mov h0, v0.h[7]
; CHECK-NEXT:    mov v2.h[3], v6.h[0]
; CHECK-NEXT:    fcvt s5, h5
; CHECK-NEXT:    fcvt s1, h1
; CHECK-NEXT:    fcvt s6, h7
; CHECK-NEXT:    mov v7.16b, v3.16b
; CHECK-NEXT:    fcvt h4, s4
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    bsl v7.16b, v17.16b, v16.16b
; CHECK-NEXT:    bit v5.16b, v6.16b, v3.16b
; CHECK-NEXT:    mov v2.h[4], v4.h[0]
; CHECK-NEXT:    bif v0.16b, v1.16b, v3.16b
; CHECK-NEXT:    fcvt h4, s7
; CHECK-NEXT:    fcvt h0, s0
; CHECK-NEXT:    mov v2.h[5], v4.h[0]
; CHECK-NEXT:    fcvt h4, s5
; CHECK-NEXT:    mov v2.h[6], v4.h[0]
; CHECK-NEXT:    mov v2.h[7], v0.h[0]
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %c = call <7 x half> @llvm.copysign.v7f16(<7 x half> %a, <7 x half> %b)
  ret <7 x half> %c
}

define <4 x half> @copysign_v4f16(<4 x half> %a, <4 x half> %b) {
; CHECK-LABEL: copysign_v4f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    // kill: def $d1 killed $d1 def $q1
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    mov h3, v1.h[1]
; CHECK-NEXT:    mov h4, v0.h[1]
; CHECK-NEXT:    mov h5, v1.h[2]
; CHECK-NEXT:    mov h6, v0.h[2]
; CHECK-NEXT:    mvni v2.4s, #128, lsl #24
; CHECK-NEXT:    fcvt s7, h1
; CHECK-NEXT:    fcvt s16, h0
; CHECK-NEXT:    mov h1, v1.h[3]
; CHECK-NEXT:    fcvt s3, h3
; CHECK-NEXT:    fcvt s4, h4
; CHECK-NEXT:    fcvt s1, h1
; CHECK-NEXT:    bit v3.16b, v4.16b, v2.16b
; CHECK-NEXT:    fcvt s4, h5
; CHECK-NEXT:    fcvt s5, h6
; CHECK-NEXT:    mov v6.16b, v2.16b
; CHECK-NEXT:    bsl v6.16b, v16.16b, v7.16b
; CHECK-NEXT:    mov h7, v0.h[3]
; CHECK-NEXT:    bit v4.16b, v5.16b, v2.16b
; CHECK-NEXT:    fcvt h3, s3
; CHECK-NEXT:    fcvt h0, s6
; CHECK-NEXT:    fcvt s5, h7
; CHECK-NEXT:    mov v0.h[1], v3.h[0]
; CHECK-NEXT:    fcvt h3, s4
; CHECK-NEXT:    bit v1.16b, v5.16b, v2.16b
; CHECK-NEXT:    mov v0.h[2], v3.h[0]
; CHECK-NEXT:    fcvt h1, s1
; CHECK-NEXT:    mov v0.h[3], v1.h[0]
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
entry:
  %c = call <4 x half> @llvm.copysign.v4f16(<4 x half> %a, <4 x half> %b)
  ret <4 x half> %c
}

define <8 x half> @copysign_v8f16(<8 x half> %a, <8 x half> %b) {
; CHECK-LABEL: copysign_v8f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov h2, v1.h[1]
; CHECK-NEXT:    mov h4, v0.h[1]
; CHECK-NEXT:    fcvt s5, h1
; CHECK-NEXT:    fcvt s6, h0
; CHECK-NEXT:    mvni v3.4s, #128, lsl #24
; CHECK-NEXT:    mov h7, v1.h[2]
; CHECK-NEXT:    mov h16, v0.h[2]
; CHECK-NEXT:    mov h17, v1.h[3]
; CHECK-NEXT:    fcvt s2, h2
; CHECK-NEXT:    fcvt s4, h4
; CHECK-NEXT:    bit v5.16b, v6.16b, v3.16b
; CHECK-NEXT:    mov h6, v0.h[3]
; CHECK-NEXT:    fcvt s7, h7
; CHECK-NEXT:    fcvt s16, h16
; CHECK-NEXT:    fcvt s17, h17
; CHECK-NEXT:    bif v4.16b, v2.16b, v3.16b
; CHECK-NEXT:    fcvt h2, s5
; CHECK-NEXT:    mov v5.16b, v3.16b
; CHECK-NEXT:    fcvt s6, h6
; CHECK-NEXT:    bsl v5.16b, v16.16b, v7.16b
; CHECK-NEXT:    fcvt h4, s4
; CHECK-NEXT:    mov h7, v1.h[4]
; CHECK-NEXT:    mov h16, v0.h[4]
; CHECK-NEXT:    bif v6.16b, v17.16b, v3.16b
; CHECK-NEXT:    mov h17, v0.h[5]
; CHECK-NEXT:    fcvt h5, s5
; CHECK-NEXT:    mov v2.h[1], v4.h[0]
; CHECK-NEXT:    fcvt s4, h7
; CHECK-NEXT:    fcvt s7, h16
; CHECK-NEXT:    mov h16, v1.h[5]
; CHECK-NEXT:    fcvt h6, s6
; CHECK-NEXT:    fcvt s17, h17
; CHECK-NEXT:    mov v2.h[2], v5.h[0]
; CHECK-NEXT:    mov h5, v1.h[6]
; CHECK-NEXT:    mov h1, v1.h[7]
; CHECK-NEXT:    bit v4.16b, v7.16b, v3.16b
; CHECK-NEXT:    mov h7, v0.h[6]
; CHECK-NEXT:    fcvt s16, h16
; CHECK-NEXT:    mov h0, v0.h[7]
; CHECK-NEXT:    mov v2.h[3], v6.h[0]
; CHECK-NEXT:    fcvt s5, h5
; CHECK-NEXT:    fcvt s1, h1
; CHECK-NEXT:    fcvt s6, h7
; CHECK-NEXT:    mov v7.16b, v3.16b
; CHECK-NEXT:    fcvt h4, s4
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    bsl v7.16b, v17.16b, v16.16b
; CHECK-NEXT:    bit v5.16b, v6.16b, v3.16b
; CHECK-NEXT:    mov v2.h[4], v4.h[0]
; CHECK-NEXT:    bif v0.16b, v1.16b, v3.16b
; CHECK-NEXT:    fcvt h4, s7
; CHECK-NEXT:    fcvt h0, s0
; CHECK-NEXT:    mov v2.h[5], v4.h[0]
; CHECK-NEXT:    fcvt h4, s5
; CHECK-NEXT:    mov v2.h[6], v4.h[0]
; CHECK-NEXT:    mov v2.h[7], v0.h[0]
; CHECK-NEXT:    mov v0.16b, v2.16b
; CHECK-NEXT:    ret
entry:
  %c = call <8 x half> @llvm.copysign.v8f16(<8 x half> %a, <8 x half> %b)
  ret <8 x half> %c
}

define <16 x half> @copysign_v16f16(<16 x half> %a, <16 x half> %b) {
; CHECK-LABEL: copysign_v16f16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    mov h4, v2.h[1]
; CHECK-NEXT:    mov h5, v0.h[1]
; CHECK-NEXT:    mvni v6.4s, #128, lsl #24
; CHECK-NEXT:    mov h7, v3.h[1]
; CHECK-NEXT:    mov h16, v1.h[1]
; CHECK-NEXT:    fcvt s17, h2
; CHECK-NEXT:    fcvt s18, h0
; CHECK-NEXT:    mov h19, v2.h[2]
; CHECK-NEXT:    mov h20, v0.h[2]
; CHECK-NEXT:    fcvt s21, h3
; CHECK-NEXT:    fcvt s22, h1
; CHECK-NEXT:    mov h23, v3.h[2]
; CHECK-NEXT:    fcvt s4, h4
; CHECK-NEXT:    fcvt s5, h5
; CHECK-NEXT:    mov h24, v1.h[2]
; CHECK-NEXT:    fcvt s7, h7
; CHECK-NEXT:    fcvt s16, h16
; CHECK-NEXT:    mov h25, v1.h[3]
; CHECK-NEXT:    mov h26, v1.h[6]
; CHECK-NEXT:    bit v21.16b, v22.16b, v6.16b
; CHECK-NEXT:    fcvt s22, h23
; CHECK-NEXT:    bit v4.16b, v5.16b, v6.16b
; CHECK-NEXT:    mov v5.16b, v6.16b
; CHECK-NEXT:    fcvt s23, h24
; CHECK-NEXT:    bit v7.16b, v16.16b, v6.16b
; CHECK-NEXT:    mov h24, v3.h[3]
; CHECK-NEXT:    bsl v5.16b, v18.16b, v17.16b
; CHECK-NEXT:    fcvt s18, h19
; CHECK-NEXT:    fcvt s19, h20
; CHECK-NEXT:    mov h20, v0.h[3]
; CHECK-NEXT:    mov h17, v2.h[3]
; CHECK-NEXT:    fcvt h16, s4
; CHECK-NEXT:    fcvt h7, s7
; CHECK-NEXT:    fcvt h4, s5
; CHECK-NEXT:    bit v18.16b, v19.16b, v6.16b
; CHECK-NEXT:    fcvt h5, s21
; CHECK-NEXT:    fcvt s19, h20
; CHECK-NEXT:    mov v20.16b, v6.16b
; CHECK-NEXT:    fcvt s17, h17
; CHECK-NEXT:    fcvt s21, h25
; CHECK-NEXT:    mov h25, v0.h[6]
; CHECK-NEXT:    bsl v20.16b, v23.16b, v22.16b
; CHECK-NEXT:    mov v4.h[1], v16.h[0]
; CHECK-NEXT:    fcvt s16, h24
; CHECK-NEXT:    fcvt h18, s18
; CHECK-NEXT:    mov h22, v2.h[4]
; CHECK-NEXT:    mov h23, v0.h[4]
; CHECK-NEXT:    bit v17.16b, v19.16b, v6.16b
; CHECK-NEXT:    mov h19, v3.h[4]
; CHECK-NEXT:    mov h24, v1.h[4]
; CHECK-NEXT:    mov v5.h[1], v7.h[0]
; CHECK-NEXT:    fcvt h7, s20
; CHECK-NEXT:    bit v16.16b, v21.16b, v6.16b
; CHECK-NEXT:    mov v4.h[2], v18.h[0]
; CHECK-NEXT:    fcvt s18, h22
; CHECK-NEXT:    fcvt s20, h23
; CHECK-NEXT:    fcvt h17, s17
; CHECK-NEXT:    fcvt s19, h19
; CHECK-NEXT:    fcvt s21, h24
; CHECK-NEXT:    mov h22, v2.h[5]
; CHECK-NEXT:    mov h23, v0.h[5]
; CHECK-NEXT:    mov h24, v1.h[5]
; CHECK-NEXT:    mov v5.h[2], v7.h[0]
; CHECK-NEXT:    fcvt h7, s16
; CHECK-NEXT:    mov h16, v3.h[5]
; CHECK-NEXT:    bit v18.16b, v20.16b, v6.16b
; CHECK-NEXT:    mov h20, v2.h[6]
; CHECK-NEXT:    mov h2, v2.h[7]
; CHECK-NEXT:    bit v19.16b, v21.16b, v6.16b
; CHECK-NEXT:    mov h21, v3.h[6]
; CHECK-NEXT:    mov v4.h[3], v17.h[0]
; CHECK-NEXT:    fcvt s17, h22
; CHECK-NEXT:    fcvt s22, h23
; CHECK-NEXT:    fcvt s23, h25
; CHECK-NEXT:    mov v5.h[3], v7.h[0]
; CHECK-NEXT:    fcvt s7, h16
; CHECK-NEXT:    fcvt s16, h24
; CHECK-NEXT:    fcvt h18, s18
; CHECK-NEXT:    fcvt s20, h20
; CHECK-NEXT:    fcvt s24, h26
; CHECK-NEXT:    fcvt h19, s19
; CHECK-NEXT:    fcvt s21, h21
; CHECK-NEXT:    mov h0, v0.h[7]
; CHECK-NEXT:    bit v17.16b, v22.16b, v6.16b
; CHECK-NEXT:    mov h3, v3.h[7]
; CHECK-NEXT:    mov h1, v1.h[7]
; CHECK-NEXT:    bit v7.16b, v16.16b, v6.16b
; CHECK-NEXT:    mov v16.16b, v6.16b
; CHECK-NEXT:    fcvt s2, h2
; CHECK-NEXT:    mov v4.h[4], v18.h[0]
; CHECK-NEXT:    mov v18.16b, v6.16b
; CHECK-NEXT:    mov v5.h[4], v19.h[0]
; CHECK-NEXT:    fcvt s0, h0
; CHECK-NEXT:    bsl v16.16b, v23.16b, v20.16b
; CHECK-NEXT:    fcvt h17, s17
; CHECK-NEXT:    fcvt s3, h3
; CHECK-NEXT:    bsl v18.16b, v24.16b, v21.16b
; CHECK-NEXT:    fcvt h7, s7
; CHECK-NEXT:    fcvt s1, h1
; CHECK-NEXT:    bif v0.16b, v2.16b, v6.16b
; CHECK-NEXT:    mov v4.h[5], v17.h[0]
; CHECK-NEXT:    fcvt h2, s16
; CHECK-NEXT:    mov v5.h[5], v7.h[0]
; CHECK-NEXT:    fcvt h7, s18
; CHECK-NEXT:    bif v1.16b, v3.16b, v6.16b
; CHECK-NEXT:    fcvt h0, s0
; CHECK-NEXT:    mov v4.h[6], v2.h[0]
; CHECK-NEXT:    mov v5.h[6], v7.h[0]
; CHECK-NEXT:    fcvt h1, s1
; CHECK-NEXT:    mov v4.h[7], v0.h[0]
; CHECK-NEXT:    mov v5.h[7], v1.h[0]
; CHECK-NEXT:    mov v0.16b, v4.16b
; CHECK-NEXT:    mov v1.16b, v5.16b
; CHECK-NEXT:    ret
entry:
  %c = call <16 x half> @llvm.copysign.v16f16(<16 x half> %a, <16 x half> %b)
  ret <16 x half> %c
}

declare <16 x half> @llvm.copysign.v16f16(<16 x half>, <16 x half>)
declare <2 x double> @llvm.copysign.v2f64(<2 x double>, <2 x double>)
declare <2 x float> @llvm.copysign.v2f32(<2 x float>, <2 x float>)
declare <3 x double> @llvm.copysign.v3f64(<3 x double>, <3 x double>)
declare <3 x float> @llvm.copysign.v3f32(<3 x float>, <3 x float>)
declare <4 x double> @llvm.copysign.v4f64(<4 x double>, <4 x double>)
declare <4 x float> @llvm.copysign.v4f32(<4 x float>, <4 x float>)
declare <4 x half> @llvm.copysign.v4f16(<4 x half>, <4 x half>)
declare <7 x half> @llvm.copysign.v7f16(<7 x half>, <7 x half>)
declare <8 x float> @llvm.copysign.v8f32(<8 x float>, <8 x float>)
declare <8 x half> @llvm.copysign.v8f16(<8 x half>, <8 x half>)
declare double @llvm.copysign.f64(double, double)
declare float @llvm.copysign.f32(float, float)
declare half @llvm.copysign.f16(half, half)
