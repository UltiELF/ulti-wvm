; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py

; RUN: llc -verify-machineinstrs -csky-no-aliases < %s -mtriple=csky  -mattr=+2e3 -mattr=+fpuv2_sf -mattr=+fpuv2_df -mattr=+hard-float | FileCheck %s

define float @FADD_FLOAT(float %x, float %y) {
; CHECK-LABEL: FADD_FLOAT:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmtvrl vr0, a1
; CHECK-NEXT:    fmtvrl vr1, a0
; CHECK-NEXT:    fadds vr0, vr0, vr1
; CHECK-NEXT:    fmfvrl a0, vr0
; CHECK-NEXT:    rts16
entry:
  %fadd = fadd  float %y, %x
  ret float %fadd
}

define double @FADD_DOUBLE(double %x, double %y) {
; CHECK-LABEL: FADD_DOUBLE:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    fmtvrl vr0, a0
; CHECK-NEXT:    fmtvrh vr0, a1
; CHECK-NEXT:    fmtvrl vr1, a2
; CHECK-NEXT:    fmtvrh vr1, a3
; CHECK-NEXT:    faddd vr0, vr1, vr0
; CHECK-NEXT:    fmfvrl a0, vr0
; CHECK-NEXT:    fmfvrh a1, vr0
; CHECK-NEXT:    rts16
entry:
  %fadd = fadd  double %y, %x
  ret double %fadd
}


