; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

; These test should allow scheduling of the loads before the stores.

define void @scalable_v16i8(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: scalable_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    ld1b { z1.b }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    mul z2.b, p0/m, z2.b, z0.b
; CHECK-NEXT:    movprfx z3, z1
; CHECK-NEXT:    mul z3.b, p0/m, z3.b, z1.b
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    eor z1.d, z3.d, z1.d
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    st1b { z1.b }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 16 x i8>, ptr %l0, align 16
  %l5 = mul <vscale x 16 x i8> %l3, %l3
  %l6 = xor <vscale x 16 x i8> %l5, %l3
  store <vscale x 16 x i8> %l6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 4
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 16 x i8>, ptr %l9, align 16
  %l13 = mul <vscale x 16 x i8> %l11, %l11
  %l14 = xor <vscale x 16 x i8> %l13, %l11
  store <vscale x 16 x i8> %l14, ptr %l9, align 16
  ret void
}

define void @scalable_v8i16(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: scalable_v8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ld1h { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ld1h { z1.h }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    mul z2.h, p0/m, z2.h, z0.h
; CHECK-NEXT:    movprfx z3, z1
; CHECK-NEXT:    mul z3.h, p0/m, z3.h, z1.h
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    eor z1.d, z3.d, z1.d
; CHECK-NEXT:    st1h { z0.h }, p0, [x0]
; CHECK-NEXT:    st1h { z1.h }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 8 x i16>, ptr %l0, align 16
  %l5 = mul <vscale x 8 x i16> %l3, %l3
  %l6 = xor <vscale x 8 x i16> %l5, %l3
  store <vscale x 8 x i16> %l6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 4
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 8 x i16>, ptr %l9, align 16
  %l13 = mul <vscale x 8 x i16> %l11, %l11
  %l14 = xor <vscale x 8 x i16> %l13, %l11
  store <vscale x 8 x i16> %l14, ptr %l9, align 16
  ret void
}

define void @scalable_v4i32(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: scalable_v4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1w { z1.s }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    mul z2.s, p0/m, z2.s, z0.s
; CHECK-NEXT:    movprfx z3, z1
; CHECK-NEXT:    mul z3.s, p0/m, z3.s, z1.s
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    eor z1.d, z3.d, z1.d
; CHECK-NEXT:    st1w { z0.s }, p0, [x0]
; CHECK-NEXT:    st1w { z1.s }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 4 x i32>, ptr %l0, align 16
  %l5 = mul <vscale x 4 x i32> %l3, %l3
  %l6 = xor <vscale x 4 x i32> %l5, %l3
  store <vscale x 4 x i32> %l6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 4
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 4 x i32>, ptr %l9, align 16
  %l13 = mul <vscale x 4 x i32> %l11, %l11
  %l14 = xor <vscale x 4 x i32> %l13, %l11
  store <vscale x 4 x i32> %l14, ptr %l9, align 16
  ret void
}

define void @scalable_v2i64(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: scalable_v2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1d { z1.d }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    mul z2.d, p0/m, z2.d, z0.d
; CHECK-NEXT:    movprfx z3, z1
; CHECK-NEXT:    mul z3.d, p0/m, z3.d, z1.d
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    eor z1.d, z3.d, z1.d
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    st1d { z1.d }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 2 x i64>, ptr %l0, align 16
  %l5 = mul <vscale x 2 x i64> %l3, %l3
  %l6 = xor <vscale x 2 x i64> %l5, %l3
  store <vscale x 2 x i64> %l6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 4
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 2 x i64>, ptr %l9, align 16
  %l13 = mul <vscale x 2 x i64> %l11, %l11
  %l14 = xor <vscale x 2 x i64> %l13, %l11
  store <vscale x 2 x i64> %l14, ptr %l9, align 16
  ret void
}

define void @scalable_v8i8(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: scalable_v8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    ld1sb { z0.h }, p0/z, [x0]
; CHECK-NEXT:    ld1sb { z1.h }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    mul z2.h, p0/m, z2.h, z0.h
; CHECK-NEXT:    movprfx z3, z1
; CHECK-NEXT:    mul z3.h, p0/m, z3.h, z1.h
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    eor z1.d, z3.d, z1.d
; CHECK-NEXT:    st1b { z0.h }, p0, [x0]
; CHECK-NEXT:    st1b { z1.h }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 8 x i8>, ptr %l0, align 16
  %s3 = sext <vscale x 8 x i8> %l3 to <vscale x 8 x i16>
  %l5 = mul <vscale x 8 x i16> %s3, %s3
  %l6 = xor <vscale x 8 x i16> %l5, %s3
  %t6 = trunc <vscale x 8 x i16> %l6 to <vscale x 8 x i8>
  store <vscale x 8 x i8> %t6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 3
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 8 x i8>, ptr %l9, align 16
  %s11 = sext <vscale x 8 x i8> %l11 to <vscale x 8 x i16>
  %l13 = mul <vscale x 8 x i16> %s11, %s11
  %l14 = xor <vscale x 8 x i16> %l13, %s11
  %t14 = trunc <vscale x 8 x i16> %l14 to <vscale x 8 x i8>
  store <vscale x 8 x i8> %t14, ptr %l9, align 16
  ret void
}

define void @scalable_v4i8(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: scalable_v4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1sb { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1sb { z1.s }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    mul z2.s, p0/m, z2.s, z0.s
; CHECK-NEXT:    movprfx z3, z1
; CHECK-NEXT:    mul z3.s, p0/m, z3.s, z1.s
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    eor z1.d, z3.d, z1.d
; CHECK-NEXT:    st1b { z0.s }, p0, [x0]
; CHECK-NEXT:    st1b { z1.s }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 4 x i8>, ptr %l0, align 16
  %s3 = sext <vscale x 4 x i8> %l3 to <vscale x 4 x i32>
  %l5 = mul <vscale x 4 x i32> %s3, %s3
  %l6 = xor <vscale x 4 x i32> %l5, %s3
  %t6 = trunc <vscale x 4 x i32> %l6 to <vscale x 4 x i8>
  store <vscale x 4 x i8> %t6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 2
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 4 x i8>, ptr %l9, align 16
  %s11 = sext <vscale x 4 x i8> %l11 to <vscale x 4 x i32>
  %l13 = mul <vscale x 4 x i32> %s11, %s11
  %l14 = xor <vscale x 4 x i32> %l13, %s11
  %t14 = trunc <vscale x 4 x i32> %l14 to <vscale x 4 x i8>
  store <vscale x 4 x i8> %t14, ptr %l9, align 16
  ret void
}

define void @scalable_v2i8(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: scalable_v2i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1sb { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1sb { z1.d }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    mul z2.d, p0/m, z2.d, z0.d
; CHECK-NEXT:    movprfx z3, z1
; CHECK-NEXT:    mul z3.d, p0/m, z3.d, z1.d
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    eor z1.d, z3.d, z1.d
; CHECK-NEXT:    st1b { z0.d }, p0, [x0]
; CHECK-NEXT:    st1b { z1.d }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 2 x i8>, ptr %l0, align 16
  %s3 = sext <vscale x 2 x i8> %l3 to <vscale x 2 x i64>
  %l5 = mul <vscale x 2 x i64> %s3, %s3
  %l6 = xor <vscale x 2 x i64> %l5, %s3
  %t6 = trunc <vscale x 2 x i64> %l6 to <vscale x 2 x i8>
  store <vscale x 2 x i8> %t6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 1
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 2 x i8>, ptr %l9, align 16
  %s11 = sext <vscale x 2 x i8> %l11 to <vscale x 2 x i64>
  %l13 = mul <vscale x 2 x i64> %s11, %s11
  %l14 = xor <vscale x 2 x i64> %l13, %s11
  %t14 = trunc <vscale x 2 x i64> %l14 to <vscale x 2 x i8>
  store <vscale x 2 x i8> %t14, ptr %l9, align 16
  ret void
}

define void @scalable_v4i16(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: scalable_v4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1sh { z0.s }, p0/z, [x0]
; CHECK-NEXT:    ld1sh { z1.s }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    mul z2.s, p0/m, z2.s, z0.s
; CHECK-NEXT:    movprfx z3, z1
; CHECK-NEXT:    mul z3.s, p0/m, z3.s, z1.s
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    eor z1.d, z3.d, z1.d
; CHECK-NEXT:    st1h { z0.s }, p0, [x0]
; CHECK-NEXT:    st1h { z1.s }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 4 x i16>, ptr %l0, align 16
  %s3 = sext <vscale x 4 x i16> %l3 to <vscale x 4 x i32>
  %l5 = mul <vscale x 4 x i32> %s3, %s3
  %l6 = xor <vscale x 4 x i32> %l5, %s3
  %t6 = trunc <vscale x 4 x i32> %l6 to <vscale x 4 x i16>
  store <vscale x 4 x i16> %t6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 3
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 4 x i16>, ptr %l9, align 16
  %s11 = sext <vscale x 4 x i16> %l11 to <vscale x 4 x i32>
  %l13 = mul <vscale x 4 x i32> %s11, %s11
  %l14 = xor <vscale x 4 x i32> %l13, %s11
  %t14 = trunc <vscale x 4 x i32> %l14 to <vscale x 4 x i16>
  store <vscale x 4 x i16> %t14, ptr %l9, align 16
  ret void
}

define void @scalable_v2i16(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: scalable_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1sh { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1sh { z1.d }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    mul z2.d, p0/m, z2.d, z0.d
; CHECK-NEXT:    movprfx z3, z1
; CHECK-NEXT:    mul z3.d, p0/m, z3.d, z1.d
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    eor z1.d, z3.d, z1.d
; CHECK-NEXT:    st1h { z0.d }, p0, [x0]
; CHECK-NEXT:    st1h { z1.d }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 2 x i16>, ptr %l0, align 16
  %s3 = sext <vscale x 2 x i16> %l3 to <vscale x 2 x i64>
  %l5 = mul <vscale x 2 x i64> %s3, %s3
  %l6 = xor <vscale x 2 x i64> %l5, %s3
  %t6 = trunc <vscale x 2 x i64> %l6 to <vscale x 2 x i16>
  store <vscale x 2 x i16> %t6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 2
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 2 x i16>, ptr %l9, align 16
  %s11 = sext <vscale x 2 x i16> %l11 to <vscale x 2 x i64>
  %l13 = mul <vscale x 2 x i64> %s11, %s11
  %l14 = xor <vscale x 2 x i64> %l13, %s11
  %t14 = trunc <vscale x 2 x i64> %l14 to <vscale x 2 x i16>
  store <vscale x 2 x i16> %t14, ptr %l9, align 16
  ret void
}

define void @scalable_v2i32(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: scalable_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    ld1sw { z0.d }, p0/z, [x0]
; CHECK-NEXT:    ld1sw { z1.d }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    movprfx z2, z0
; CHECK-NEXT:    mul z2.d, p0/m, z2.d, z0.d
; CHECK-NEXT:    movprfx z3, z1
; CHECK-NEXT:    mul z3.d, p0/m, z3.d, z1.d
; CHECK-NEXT:    eor z0.d, z2.d, z0.d
; CHECK-NEXT:    eor z1.d, z3.d, z1.d
; CHECK-NEXT:    st1w { z0.d }, p0, [x0]
; CHECK-NEXT:    st1w { z1.d }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 2 x i32>, ptr %l0, align 16
  %s3 = sext <vscale x 2 x i32> %l3 to <vscale x 2 x i64>
  %l5 = mul <vscale x 2 x i64> %s3, %s3
  %l6 = xor <vscale x 2 x i64> %l5, %s3
  %t6 = trunc <vscale x 2 x i64> %l6 to <vscale x 2 x i32>
  store <vscale x 2 x i32> %t6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 3
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 2 x i32>, ptr %l9, align 16
  %s11 = sext <vscale x 2 x i32> %l11 to <vscale x 2 x i64>
  %l13 = mul <vscale x 2 x i64> %s11, %s11
  %l14 = xor <vscale x 2 x i64> %l13, %s11
  %t14 = trunc <vscale x 2 x i64> %l14 to <vscale x 2 x i32>
  store <vscale x 2 x i32> %t14, ptr %l9, align 16
  ret void
}

define void @negative_tooshort_v16i8(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: negative_tooshort_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    cnth x8
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.b, p0/m, z1.b, z0.b
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0, x8]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.b, p0/m, z1.b, z0.b
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1b { z0.b }, p0, [x0, x8]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 16 x i8>, ptr %l0, align 16
  %l5 = mul <vscale x 16 x i8> %l3, %l3
  %l6 = xor <vscale x 16 x i8> %l5, %l3
  store <vscale x 16 x i8> %l6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 3
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 16 x i8>, ptr %l9, align 16
  %l13 = mul <vscale x 16 x i8> %l11, %l11
  %l14 = xor <vscale x 16 x i8> %l13, %l11
  store <vscale x 16 x i8> %l14, ptr %l9, align 16
  ret void
}

define void @negative_scalable_v2i8(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: negative_scalable_v2i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    lsr x8, x8, #4
; CHECK-NEXT:    ld1sb { z0.d }, p0/z, [x0]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z0.d
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1b { z0.d }, p0, [x0]
; CHECK-NEXT:    ld1sb { z0.d }, p0/z, [x0, x8]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z0.d
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1b { z0.d }, p0, [x0, x8]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 2 x i8>, ptr %l0, align 16
  %s3 = sext <vscale x 2 x i8> %l3 to <vscale x 2 x i64>
  %l5 = mul <vscale x 2 x i64> %s3, %s3
  %l6 = xor <vscale x 2 x i64> %l5, %s3
  %t6 = trunc <vscale x 2 x i64> %l6 to <vscale x 2 x i8>
  store <vscale x 2 x i8> %t6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 0
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 2 x i8>, ptr %l9, align 16
  %s11 = sext <vscale x 2 x i8> %l11 to <vscale x 2 x i64>
  %l13 = mul <vscale x 2 x i64> %s11, %s11
  %l14 = xor <vscale x 2 x i64> %l13, %s11
  %t14 = trunc <vscale x 2 x i64> %l14 to <vscale x 2 x i8>
  store <vscale x 2 x i8> %t14, ptr %l9, align 16
  ret void
}

define void @negative_scalable_v2i16(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: negative_scalable_v2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    cntd x8
; CHECK-NEXT:    add x8, x0, x8
; CHECK-NEXT:    ld1sh { z0.d }, p0/z, [x0]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z0.d
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1h { z0.d }, p0, [x0]
; CHECK-NEXT:    ld1sh { z0.d }, p0/z, [x8]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z0.d
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1h { z0.d }, p0, [x8]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 2 x i16>, ptr %l0, align 16
  %s3 = sext <vscale x 2 x i16> %l3 to <vscale x 2 x i64>
  %l5 = mul <vscale x 2 x i64> %s3, %s3
  %l6 = xor <vscale x 2 x i64> %l5, %s3
  %t6 = trunc <vscale x 2 x i64> %l6 to <vscale x 2 x i16>
  store <vscale x 2 x i16> %t6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 1
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 2 x i16>, ptr %l9, align 16
  %s11 = sext <vscale x 2 x i16> %l11 to <vscale x 2 x i64>
  %l13 = mul <vscale x 2 x i64> %s11, %s11
  %l14 = xor <vscale x 2 x i64> %l13, %s11
  %t14 = trunc <vscale x 2 x i64> %l14 to <vscale x 2 x i16>
  store <vscale x 2 x i16> %t14, ptr %l9, align 16
  ret void
}

define void @negative_scalable_v2i32(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: negative_scalable_v2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    cntw x8
; CHECK-NEXT:    add x8, x0, x8
; CHECK-NEXT:    ld1sw { z0.d }, p0/z, [x0]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z0.d
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1w { z0.d }, p0, [x0]
; CHECK-NEXT:    ld1sw { z0.d }, p0/z, [x8]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.d, p0/m, z1.d, z0.d
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1w { z0.d }, p0, [x8]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 2 x i32>, ptr %l0, align 16
  %s3 = sext <vscale x 2 x i32> %l3 to <vscale x 2 x i64>
  %l5 = mul <vscale x 2 x i64> %s3, %s3
  %l6 = xor <vscale x 2 x i64> %l5, %s3
  %t6 = trunc <vscale x 2 x i64> %l6 to <vscale x 2 x i32>
  store <vscale x 2 x i32> %t6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 2
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 2 x i32>, ptr %l9, align 16
  %s11 = sext <vscale x 2 x i32> %l11 to <vscale x 2 x i64>
  %l13 = mul <vscale x 2 x i64> %s11, %s11
  %l14 = xor <vscale x 2 x i64> %l13, %s11
  %t14 = trunc <vscale x 2 x i64> %l14 to <vscale x 2 x i32>
  store <vscale x 2 x i32> %t14, ptr %l9, align 16
  ret void
}

define void @triple_v16i8(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: triple_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    ld1b { z1.b }, p0/z, [x0, #1, mul vl]
; CHECK-NEXT:    ld1b { z2.b }, p0/z, [x0, #2, mul vl]
; CHECK-NEXT:    movprfx z3, z0
; CHECK-NEXT:    mul z3.b, p0/m, z3.b, z0.b
; CHECK-NEXT:    movprfx z4, z1
; CHECK-NEXT:    mul z4.b, p0/m, z4.b, z1.b
; CHECK-NEXT:    movprfx z5, z2
; CHECK-NEXT:    mul z5.b, p0/m, z5.b, z2.b
; CHECK-NEXT:    eor z0.d, z3.d, z0.d
; CHECK-NEXT:    eor z1.d, z4.d, z1.d
; CHECK-NEXT:    eor z2.d, z5.d, z2.d
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    st1b { z1.b }, p0, [x0, #1, mul vl]
; CHECK-NEXT:    st1b { z2.b }, p0, [x0, #2, mul vl]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 16 x i8>, ptr %l0, align 16
  %l5 = mul <vscale x 16 x i8> %l3, %l3
  %l6 = xor <vscale x 16 x i8> %l5, %l3
  store <vscale x 16 x i8> %l6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 4
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 16 x i8>, ptr %l9, align 16
  %l13 = mul <vscale x 16 x i8> %l11, %l11
  %l14 = xor <vscale x 16 x i8> %l13, %l11
  store <vscale x 16 x i8> %l14, ptr %l9, align 16
  %m9 = getelementptr inbounds i8, ptr %l9, i64 %l8
  %m11 = load <vscale x 16 x i8>, ptr %m9, align 16
  %m13 = mul <vscale x 16 x i8> %m11, %m11
  %m14 = xor <vscale x 16 x i8> %m13, %m11
  store <vscale x 16 x i8> %m14, ptr %m9, align 16
  ret void
}

define void @negative_tripletooshort_v16i8(ptr noalias nocapture noundef %l0) {
; CHECK-LABEL: negative_tripletooshort_v16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    cntw x8
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.b, p0/m, z1.b, z0.b
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1b { z0.b }, p0, [x0]
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0, x8]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.b, p0/m, z1.b, z0.b
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1b { z0.b }, p0, [x0, x8]
; CHECK-NEXT:    cnth x8
; CHECK-NEXT:    ld1b { z0.b }, p0/z, [x0, x8]
; CHECK-NEXT:    movprfx z1, z0
; CHECK-NEXT:    mul z1.b, p0/m, z1.b, z0.b
; CHECK-NEXT:    eor z0.d, z1.d, z0.d
; CHECK-NEXT:    st1b { z0.b }, p0, [x0, x8]
; CHECK-NEXT:    ret
  %l3 = load <vscale x 16 x i8>, ptr %l0, align 16
  %l5 = mul <vscale x 16 x i8> %l3, %l3
  %l6 = xor <vscale x 16 x i8> %l5, %l3
  store <vscale x 16 x i8> %l6, ptr %l0, align 16
  %l7 = tail call i64 @llvm.vscale.i64()
  %l8 = shl nuw nsw i64 %l7, 2
  %l9 = getelementptr inbounds i8, ptr %l0, i64 %l8
  %l11 = load <vscale x 16 x i8>, ptr %l9, align 16
  %l13 = mul <vscale x 16 x i8> %l11, %l11
  %l14 = xor <vscale x 16 x i8> %l13, %l11
  store <vscale x 16 x i8> %l14, ptr %l9, align 16
  %m9 = getelementptr inbounds i8, ptr %l9, i64 %l8
  %m11 = load <vscale x 16 x i8>, ptr %m9, align 16
  %m13 = mul <vscale x 16 x i8> %m11, %m11
  %m14 = xor <vscale x 16 x i8> %m13, %m11
  store <vscale x 16 x i8> %m14, ptr %m9, align 16
  ret void
}

declare i64 @llvm.vscale.i64()
