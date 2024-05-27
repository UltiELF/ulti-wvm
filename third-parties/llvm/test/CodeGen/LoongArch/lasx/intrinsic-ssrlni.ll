; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

declare <32 x i8> @llvm.loongarch.lasx.xvssrlni.b.h(<32 x i8>, <32 x i8>, i32)

define <32 x i8> @lasx_xvssrlni_b_h(<32 x i8> %va, <32 x i8> %vb) nounwind {
; CHECK-LABEL: lasx_xvssrlni_b_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvssrlni.b.h $xr0, $xr1, 1
; CHECK-NEXT:    ret
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvssrlni.b.h(<32 x i8> %va, <32 x i8> %vb, i32 1)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvssrlni.h.w(<16 x i16>, <16 x i16>, i32)

define <16 x i16> @lasx_xvssrlni_h_w(<16 x i16> %va, <16 x i16> %vb) nounwind {
; CHECK-LABEL: lasx_xvssrlni_h_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvssrlni.h.w $xr0, $xr1, 1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvssrlni.h.w(<16 x i16> %va, <16 x i16> %vb, i32 1)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvssrlni.w.d(<8 x i32>, <8 x i32>, i32)

define <8 x i32> @lasx_xvssrlni_w_d(<8 x i32> %va, <8 x i32> %vb) nounwind {
; CHECK-LABEL: lasx_xvssrlni_w_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvssrlni.w.d $xr0, $xr1, 1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvssrlni.w.d(<8 x i32> %va, <8 x i32> %vb, i32 1)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvssrlni.d.q(<4 x i64>, <4 x i64>, i32)

define <4 x i64> @lasx_xvssrlni_d_q(<4 x i64> %va, <4 x i64> %vb) nounwind {
; CHECK-LABEL: lasx_xvssrlni_d_q:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvssrlni.d.q $xr0, $xr1, 1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvssrlni.d.q(<4 x i64> %va, <4 x i64> %vb, i32 1)
  ret <4 x i64> %res
}

declare <32 x i8> @llvm.loongarch.lasx.xvssrlni.bu.h(<32 x i8>, <32 x i8>, i32)

define <32 x i8> @lasx_xvssrlni_bu_h(<32 x i8> %va, <32 x i8> %vb) nounwind {
; CHECK-LABEL: lasx_xvssrlni_bu_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvssrlni.bu.h $xr0, $xr1, 1
; CHECK-NEXT:    ret
entry:
  %res = call <32 x i8> @llvm.loongarch.lasx.xvssrlni.bu.h(<32 x i8> %va, <32 x i8> %vb, i32 1)
  ret <32 x i8> %res
}

declare <16 x i16> @llvm.loongarch.lasx.xvssrlni.hu.w(<16 x i16>, <16 x i16>, i32)

define <16 x i16> @lasx_xvssrlni_hu_w(<16 x i16> %va, <16 x i16> %vb) nounwind {
; CHECK-LABEL: lasx_xvssrlni_hu_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvssrlni.hu.w $xr0, $xr1, 1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i16> @llvm.loongarch.lasx.xvssrlni.hu.w(<16 x i16> %va, <16 x i16> %vb, i32 1)
  ret <16 x i16> %res
}

declare <8 x i32> @llvm.loongarch.lasx.xvssrlni.wu.d(<8 x i32>, <8 x i32>, i32)

define <8 x i32> @lasx_xvssrlni_wu_d(<8 x i32> %va, <8 x i32> %vb) nounwind {
; CHECK-LABEL: lasx_xvssrlni_wu_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvssrlni.wu.d $xr0, $xr1, 1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i32> @llvm.loongarch.lasx.xvssrlni.wu.d(<8 x i32> %va, <8 x i32> %vb, i32 1)
  ret <8 x i32> %res
}

declare <4 x i64> @llvm.loongarch.lasx.xvssrlni.du.q(<4 x i64>, <4 x i64>, i32)

define <4 x i64> @lasx_xvssrlni_du_q(<4 x i64> %va, <4 x i64> %vb) nounwind {
; CHECK-LABEL: lasx_xvssrlni_du_q:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvssrlni.du.q $xr0, $xr1, 1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i64> @llvm.loongarch.lasx.xvssrlni.du.q(<4 x i64> %va, <4 x i64> %vb, i32 1)
  ret <4 x i64> %res
}
