; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare <16 x i8> @llvm.loongarch.lsx.vsrlrn.b.h(<8 x i16>, <8 x i16>)

define <16 x i8> @lsx_vsrlrn_b_h(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vsrlrn_b_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsrlrn.b.h $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vsrlrn.b.h(<8 x i16> %va, <8 x i16> %vb)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vsrlrn.h.w(<4 x i32>, <4 x i32>)

define <8 x i16> @lsx_vsrlrn_h_w(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vsrlrn_h_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsrlrn.h.w $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vsrlrn.h.w(<4 x i32> %va, <4 x i32> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vsrlrn.w.d(<2 x i64>, <2 x i64>)

define <4 x i32> @lsx_vsrlrn_w_d(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vsrlrn_w_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsrlrn.w.d $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vsrlrn.w.d(<2 x i64> %va, <2 x i64> %vb)
  ret <4 x i32> %res
}
