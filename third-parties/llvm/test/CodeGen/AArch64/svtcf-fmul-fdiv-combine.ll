; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple aarch64-none-linux-gnu -enable-unsafe-fp-math -mattr=+fullfp16 < %s | FileCheck %s

define half @scvtf_f16_2(i32 %state) {
; CHECK-LABEL: scvtf_f16_2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf h0, w0, #1
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i32 %state to half
  %div = fmul half %conv, 5.000000e-01
  ret half %div
}

define half @scvtf_f16_4(i32 %state) {
; CHECK-LABEL: scvtf_f16_4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf h0, w0, #2
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i32 %state to half
  %div = fmul half %conv, 2.500000e-01
  ret half %div
}

define half @scvtf_f16_8(i32 %state) {
; CHECK-LABEL: scvtf_f16_8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf h0, w0, #3
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i32 %state to half
  %div = fmul half %conv, 1.250000e-01
  ret half %div
}

define half @scvtf_f16_16(i32 %state) {
; CHECK-LABEL: scvtf_f16_16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf h0, w0, #4
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i32 %state to half
  %div = fmul half %conv, 6.250000e-02
  ret half %div
}

define half @scvtf_f16_32(i32 %state) {
; CHECK-LABEL: scvtf_f16_32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf h0, w0, #5
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i32 %state to half
  %div = fmul half %conv, 3.125000e-02
  ret half %div
}

define float @scvtf_f32_2(i32 %state) {
; CHECK-LABEL: scvtf_f32_2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf s0, w0, #1
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i32 %state to float
  %div = fmul float %conv, 5.000000e-01
  ret float %div
}

define float @scvtf_f32_4(i32 %state) {
; CHECK-LABEL: scvtf_f32_4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf s0, w0, #2
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i32 %state to float
  %div = fmul float %conv, 2.500000e-01
  ret float %div
}

define float @scvtf_f32_8(i32 %state) {
; CHECK-LABEL: scvtf_f32_8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf s0, w0, #3
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i32 %state to float
  %div = fmul float %conv, 1.250000e-01
  ret float %div
}

define float @scvtf_f32_16(i32 %state) {
; CHECK-LABEL: scvtf_f32_16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf s0, w0, #4
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i32 %state to float
  %div = fmul float %conv, 6.250000e-02
  ret float %div
}

define float @scvtf_f32_32(i32 %state) {
; CHECK-LABEL: scvtf_f32_32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf s0, w0, #5
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i32 %state to float
  %div = fmul float %conv, 3.125000e-02
  ret float %div
}

define double @scvtf_f64_2(i64 %state) {
; CHECK-LABEL: scvtf_f64_2:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf d0, x0, #1
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i64 %state to double
  %div = fmul double %conv, 5.000000e-01
  ret double %div
}

define double @scvtf_f64_4(i64 %state) {
; CHECK-LABEL: scvtf_f64_4:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf d0, x0, #2
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i64 %state to double
  %div = fmul double %conv, 2.500000e-01
  ret double %div
}

define double @scvtf_f64_8(i64 %state) {
; CHECK-LABEL: scvtf_f64_8:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf d0, x0, #3
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i64 %state to double
  %div = fmul double %conv, 1.250000e-01
  ret double %div
}

define double @scvtf_f64_16(i64 %state) {
; CHECK-LABEL: scvtf_f64_16:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf d0, x0, #4
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i64 %state to double
  %div = fmul double %conv, 6.250000e-02
  ret double %div
}

define double @scvtf_f64_32(i64 %state) {
; CHECK-LABEL: scvtf_f64_32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    scvtf d0, x0, #5
; CHECK-NEXT:    ret
entry:
  %conv = sitofp i64 %state to double
  %div = fmul double %conv, 3.125000e-02
  ret double %div
}
