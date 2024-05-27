; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

define void @mulhs_v32i8(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mulhs_v32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvmuh.b $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %v0s = sext <32 x i8> %v0 to <32 x i16>
  %v1s = sext <32 x i8> %v1 to <32 x i16>
  %m = mul <32 x i16> %v0s, %v1s
  %s = ashr <32 x i16> %m, <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
  %v2 = trunc <32 x i16> %s to <32 x i8>
  store <32 x i8> %v2, ptr %res
  ret void
}

define void @mulhu_v32i8(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mulhu_v32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvmuh.bu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <32 x i8>, ptr %a0
  %v1 = load <32 x i8>, ptr %a1
  %v0z = zext <32 x i8> %v0 to <32 x i16>
  %v1z = zext <32 x i8> %v1 to <32 x i16>
  %m = mul <32 x i16> %v0z, %v1z
  %s = lshr <32 x i16> %m, <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
  %v2 = trunc <32 x i16> %s to <32 x i8>
  store <32 x i8> %v2, ptr %res
  ret void
}

define void @mulhs_v16i16(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mulhs_v16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvmuh.h $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %v0s = sext <16 x i16> %v0 to <16 x i32>
  %v1s = sext <16 x i16> %v1 to <16 x i32>
  %m = mul <16 x i32> %v0s, %v1s
  %s = ashr <16 x i32> %m, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %v2 = trunc <16 x i32> %s to <16 x i16>
  store <16 x i16> %v2, ptr %res
  ret void
}

define void @mulhu_v16i16(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mulhu_v16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvmuh.hu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <16 x i16>, ptr %a0
  %v1 = load <16 x i16>, ptr %a1
  %v0z = zext <16 x i16> %v0 to <16 x i32>
  %v1z = zext <16 x i16> %v1 to <16 x i32>
  %m = mul <16 x i32> %v0z, %v1z
  %s = lshr <16 x i32> %m, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %v2 = trunc <16 x i32> %s to <16 x i16>
  store <16 x i16> %v2, ptr %res
  ret void
}

define void @mulhs_v8i32(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mulhs_v8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvmuh.w $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %v0s = sext <8 x i32> %v0 to <8 x i64>
  %v1s = sext <8 x i32> %v1 to <8 x i64>
  %m = mul <8 x i64> %v0s, %v1s
  %s = ashr <8 x i64> %m, <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
  %v2 = trunc <8 x i64> %s to <8 x i32>
  store <8 x i32> %v2, ptr %res
  ret void
}

define void @mulhu_v8i32(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mulhu_v8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvmuh.wu $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <8 x i32>, ptr %a0
  %v1 = load <8 x i32>, ptr %a1
  %v0z = zext <8 x i32> %v0 to <8 x i64>
  %v1z = zext <8 x i32> %v1 to <8 x i64>
  %m = mul <8 x i64> %v0z, %v1z
  %s = lshr <8 x i64> %m, <i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32, i64 32>
  %v2 = trunc <8 x i64> %s to <8 x i32>
  store <8 x i32> %v2, ptr %res
  ret void
}

define void @mulhs_v4i64(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mulhs_v4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvmuh.d $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %v0s = sext <4 x i64> %v0 to <4 x i128>
  %v1s = sext <4 x i64> %v1 to <4 x i128>
  %m = mul <4 x i128> %v0s, %v1s
  %s = ashr <4 x i128> %m, <i128 64, i128 64, i128 64, i128 64>
  %v2 = trunc <4 x i128> %s to <4 x i64>
  store <4 x i64> %v2, ptr %res
  ret void
}

define void @mulhu_v4i64(ptr %res, ptr %a0, ptr %a1) nounwind {
; CHECK-LABEL: mulhu_v4i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    xvld $xr0, $a2, 0
; CHECK-NEXT:    xvld $xr1, $a1, 0
; CHECK-NEXT:    xvmuh.du $xr0, $xr1, $xr0
; CHECK-NEXT:    xvst $xr0, $a0, 0
; CHECK-NEXT:    ret
entry:
  %v0 = load <4 x i64>, ptr %a0
  %v1 = load <4 x i64>, ptr %a1
  %v0z = zext <4 x i64> %v0 to <4 x i128>
  %v1z = zext <4 x i64> %v1 to <4 x i128>
  %m = mul <4 x i128> %v0z, %v1z
  %s = lshr <4 x i128> %m, <i128 64, i128 64, i128 64, i128 64>
  %v2 = trunc <4 x i128> %s to <4 x i64>
  store <4 x i64> %v2, ptr %res
  ret void
}
