; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare void @llvm.loongarch.lsx.vstelm.b(<16 x i8>, i8*, i32, i32)

define void @lsx_vstelm_b(<16 x i8> %va, i8* %p) nounwind {
; CHECK-LABEL: lsx_vstelm_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vstelm.b $vr0, $a0, 1, 15
; CHECK-NEXT:    ret
entry:
  call void @llvm.loongarch.lsx.vstelm.b(<16 x i8> %va, i8* %p, i32 1, i32 15)
  ret void
}

declare void @llvm.loongarch.lsx.vstelm.h(<8 x i16>, i8*, i32, i32)

define void @lsx_vstelm_h(<8 x i16> %va, i8* %p) nounwind {
; CHECK-LABEL: lsx_vstelm_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vstelm.h $vr0, $a0, 2, 7
; CHECK-NEXT:    ret
entry:
  call void @llvm.loongarch.lsx.vstelm.h(<8 x i16> %va, i8* %p, i32 2, i32 7)
  ret void
}

declare void @llvm.loongarch.lsx.vstelm.w(<4 x i32>, i8*, i32, i32)

define void @lsx_vstelm_w(<4 x i32> %va, i8* %p) nounwind {
; CHECK-LABEL: lsx_vstelm_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vstelm.w $vr0, $a0, 4, 3
; CHECK-NEXT:    ret
entry:
  call void @llvm.loongarch.lsx.vstelm.w(<4 x i32> %va, i8* %p, i32 4, i32 3)
  ret void
}

declare void @llvm.loongarch.lsx.vstelm.d(<2 x i64>, i8*, i32, i32)

define void @lsx_vstelm_d(<2 x i64> %va, i8* %p) nounwind {
; CHECK-LABEL: lsx_vstelm_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vstelm.d $vr0, $a0, 8, 1
; CHECK-NEXT:    ret
entry:
  call void @llvm.loongarch.lsx.vstelm.d(<2 x i64> %va, i8* %p, i32 8, i32 1)
  ret void
}
