; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare <16 x i8> @llvm.loongarch.lsx.vsle.b(<16 x i8>, <16 x i8>)

define <16 x i8> @lsx_vsle_b(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vsle_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsle.b $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vsle.b(<16 x i8> %va, <16 x i8> %vb)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vsle.h(<8 x i16>, <8 x i16>)

define <8 x i16> @lsx_vsle_h(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vsle_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsle.h $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vsle.h(<8 x i16> %va, <8 x i16> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vsle.w(<4 x i32>, <4 x i32>)

define <4 x i32> @lsx_vsle_w(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vsle_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsle.w $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vsle.w(<4 x i32> %va, <4 x i32> %vb)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vsle.d(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vsle_d(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vsle_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsle.d $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vsle.d(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}

declare <16 x i8> @llvm.loongarch.lsx.vslei.b(<16 x i8>, i32)

define <16 x i8> @lsx_vslei_b(<16 x i8> %va) nounwind {
; CHECK-LABEL: lsx_vslei_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vslei.b $vr0, $vr0, 15
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vslei.b(<16 x i8> %va, i32 15)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vslei.h(<8 x i16>, i32)

define <8 x i16> @lsx_vslei_h(<8 x i16> %va) nounwind {
; CHECK-LABEL: lsx_vslei_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vslei.h $vr0, $vr0, 15
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vslei.h(<8 x i16> %va, i32 15)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vslei.w(<4 x i32>, i32)

define <4 x i32> @lsx_vslei_w(<4 x i32> %va) nounwind {
; CHECK-LABEL: lsx_vslei_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vslei.w $vr0, $vr0, -16
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vslei.w(<4 x i32> %va, i32 -16)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vslei.d(<2 x i64>, i32)

define <2 x i64> @lsx_vslei_d(<2 x i64> %va) nounwind {
; CHECK-LABEL: lsx_vslei_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vslei.d $vr0, $vr0, -16
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vslei.d(<2 x i64> %va, i32 -16)
  ret <2 x i64> %res
}

declare <16 x i8> @llvm.loongarch.lsx.vsle.bu(<16 x i8>, <16 x i8>)

define <16 x i8> @lsx_vsle_bu(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vsle_bu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsle.bu $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vsle.bu(<16 x i8> %va, <16 x i8> %vb)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vsle.hu(<8 x i16>, <8 x i16>)

define <8 x i16> @lsx_vsle_hu(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vsle_hu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsle.hu $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vsle.hu(<8 x i16> %va, <8 x i16> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vsle.wu(<4 x i32>, <4 x i32>)

define <4 x i32> @lsx_vsle_wu(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vsle_wu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsle.wu $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vsle.wu(<4 x i32> %va, <4 x i32> %vb)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vsle.du(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vsle_du(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vsle_du:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsle.du $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vsle.du(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}

declare <16 x i8> @llvm.loongarch.lsx.vslei.bu(<16 x i8>, i32)

define <16 x i8> @lsx_vslei_bu(<16 x i8> %va) nounwind {
; CHECK-LABEL: lsx_vslei_bu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vslei.bu $vr0, $vr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vslei.bu(<16 x i8> %va, i32 1)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vslei.hu(<8 x i16>, i32)

define <8 x i16> @lsx_vslei_hu(<8 x i16> %va) nounwind {
; CHECK-LABEL: lsx_vslei_hu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vslei.hu $vr0, $vr0, 1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vslei.hu(<8 x i16> %va, i32 1)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vslei.wu(<4 x i32>, i32)

define <4 x i32> @lsx_vslei_wu(<4 x i32> %va) nounwind {
; CHECK-LABEL: lsx_vslei_wu:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vslei.wu $vr0, $vr0, 31
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vslei.wu(<4 x i32> %va, i32 31)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vslei.du(<2 x i64>, i32)

define <2 x i64> @lsx_vslei_du(<2 x i64> %va) nounwind {
; CHECK-LABEL: lsx_vslei_du:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vslei.du $vr0, $vr0, 31
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vslei.du(<2 x i64> %va, i32 31)
  ret <2 x i64> %res
}
