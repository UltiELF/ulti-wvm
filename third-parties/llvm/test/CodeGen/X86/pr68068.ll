; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -fast-isel=1 | FileCheck %s

define float @f() "target-features"="+avx512f" {
; CHECK-LABEL: f:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vxorps %xmm0, %xmm0, %xmm0
; CHECK-NEXT:    retq
  %1 = uitofp i15 poison to float
  ret float %1
}
