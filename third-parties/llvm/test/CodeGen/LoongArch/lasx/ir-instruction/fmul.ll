; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

define void @fmul_v8f32(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: fmul_v8f32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvfmul.s $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x float>, ptr %a0
  %v1 = load <8 x float>, ptr %a1
  %v2 = fmul <8 x float> %v0, %v1
  store <8 x float> %v2, ptr %res
  ret void
}

define void @fmul_v4f64(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: fmul_v4f64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvfmul.d $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x double>, ptr %a0
  %v1 = load <4 x double>, ptr %a1
  %v2 = fmul <4 x double> %v0, %v1
  store <4 x double> %v2, ptr %res
  ret void
}
