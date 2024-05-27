; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare <16 x i8> @llvm.loongarch.lsx.vand.v(<16 x i8>, <16 x i8>)

define <16 x i8> @lsx_vand_v(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vand_v:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vand.v $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vand.v(<16 x i8> %va, <16 x i8> %vb)
  ret <16 x i8> %res
}
