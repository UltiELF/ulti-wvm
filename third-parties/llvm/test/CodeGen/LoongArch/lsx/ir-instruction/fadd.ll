; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

define void @fadd_v4f32(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: fadd_v4f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a2, 0
; CHECK-NEXT:    vld $vr1, $a1, 0
; CHECK-NEXT:    vfadd.s $vr0, $vr1, $vr0
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x float>, ptr %a0
  %v1 = load <4 x float>, ptr %a1
  %v2 = fadd <4 x float> %v0, %v1
  store <4 x float> %v2, ptr %res
  ret void
}

define void @fadd_v2f64(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: fadd_v2f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vld $vr0, $a2, 0
; CHECK-NEXT:    vld $vr1, $a1, 0
; CHECK-NEXT:    vfadd.d $vr0, $vr1, $vr0
; CHECK-NEXT:    vst $vr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <2 x double>, ptr %a0
  %v1 = load <2 x double>, ptr %a1
  %v2 = fadd <2 x double> %v0, %v1
  store <2 x double> %v2, ptr %res
  ret void
}
