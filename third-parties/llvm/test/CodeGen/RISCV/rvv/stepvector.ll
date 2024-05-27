; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+v -verify-machineinstrs < %s | FileCheck %s -check-prefixes=CHECK,RV32
; RUN: llc -mtriple=riscv64 -mattr=+m,+v -verify-machineinstrs < %s | FileCheck %s -check-prefixes=CHECK,RV64

declare <vscale x 1 x i8> @llvm.experimental.stepvector.nxv1i8()

define <vscale x 1 x i8> @stepvector_nxv1i8() {
; CHECK-LABEL: stepvector_nxv1i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i8> @llvm.experimental.stepvector.nxv1i8()
  ret <vscale x 1 x i8> %v
}

declare <vscale x 2 x i8> @llvm.experimental.stepvector.nxv2i8()

define <vscale x 2 x i8> @stepvector_nxv2i8() {
; CHECK-LABEL: stepvector_nxv2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i8> @llvm.experimental.stepvector.nxv2i8()
  ret <vscale x 2 x i8> %v
}

declare <vscale x 3 x i8> @llvm.experimental.stepvector.nxv3i8()

define <vscale x 3 x i8> @stepvector_nxv3i8() {
; CHECK-LABEL: stepvector_nxv3i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 3 x i8> @llvm.experimental.stepvector.nxv3i8()
  ret <vscale x 3 x i8> %v
}

declare <vscale x 4 x i8> @llvm.experimental.stepvector.nxv4i8()

define <vscale x 4 x i8> @stepvector_nxv4i8() {
; CHECK-LABEL: stepvector_nxv4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i8> @llvm.experimental.stepvector.nxv4i8()
  ret <vscale x 4 x i8> %v
}

declare <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()

define <vscale x 8 x i8> @stepvector_nxv8i8() {
; CHECK-LABEL: stepvector_nxv8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()
  ret <vscale x 8 x i8> %v
}

define <vscale x 8 x i8> @add_stepvector_nxv8i8() {
; CHECK-LABEL: add_stepvector_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vv v8, v8, v8
; CHECK-NEXT:    ret
entry:
  %0 = call <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()
  %1 = call <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()
  %2 = add <vscale x 8 x i8> %0, %1
  ret <vscale x 8 x i8> %2
}

define <vscale x 8 x i8> @mul_stepvector_nxv8i8() {
; CHECK-LABEL: mul_stepvector_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    li a0, 3
; CHECK-NEXT:    vmul.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 8 x i8> poison, i8 3, i32 0
  %1 = shufflevector <vscale x 8 x i8> %0, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %2 = call <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()
  %3 = mul <vscale x 8 x i8> %2, %1
  ret <vscale x 8 x i8> %3
}

define <vscale x 8 x i8> @shl_stepvector_nxv8i8() {
; CHECK-LABEL: shl_stepvector_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e8, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsll.vi v8, v8, 2
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 8 x i8> poison, i8 2, i32 0
  %1 = shufflevector <vscale x 8 x i8> %0, <vscale x 8 x i8> poison, <vscale x 8 x i32> zeroinitializer
  %2 = call <vscale x 8 x i8> @llvm.experimental.stepvector.nxv8i8()
  %3 = shl <vscale x 8 x i8> %2, %1
  ret <vscale x 8 x i8> %3
}

declare <vscale x 16 x i8> @llvm.experimental.stepvector.nxv16i8()

define <vscale x 16 x i8> @stepvector_nxv16i8() {
; CHECK-LABEL: stepvector_nxv16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i8> @llvm.experimental.stepvector.nxv16i8()
  ret <vscale x 16 x i8> %v
}

declare <vscale x 32 x i8> @llvm.experimental.stepvector.nxv32i8()

define <vscale x 32 x i8> @stepvector_nxv32i8() {
; CHECK-LABEL: stepvector_nxv32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i8> @llvm.experimental.stepvector.nxv32i8()
  ret <vscale x 32 x i8> %v
}

declare <vscale x 64 x i8> @llvm.experimental.stepvector.nxv64i8()

define <vscale x 64 x i8> @stepvector_nxv64i8() {
; CHECK-LABEL: stepvector_nxv64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 64 x i8> @llvm.experimental.stepvector.nxv64i8()
  ret <vscale x 64 x i8> %v
}

declare <vscale x 1 x i16> @llvm.experimental.stepvector.nxv1i16()

define <vscale x 1 x i16> @stepvector_nxv1i16() {
; CHECK-LABEL: stepvector_nxv1i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i16> @llvm.experimental.stepvector.nxv1i16()
  ret <vscale x 1 x i16> %v
}

declare <vscale x 2 x i16> @llvm.experimental.stepvector.nxv2i16()

define <vscale x 2 x i16> @stepvector_nxv2i16() {
; CHECK-LABEL: stepvector_nxv2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i16> @llvm.experimental.stepvector.nxv2i16()
  ret <vscale x 2 x i16> %v
}

declare <vscale x 2 x i15> @llvm.experimental.stepvector.nxv2i15()

define <vscale x 2 x i15> @stepvector_nxv2i15() {
; CHECK-LABEL: stepvector_nxv2i15:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i15> @llvm.experimental.stepvector.nxv2i15()
  ret <vscale x 2 x i15> %v
}

declare <vscale x 3 x i16> @llvm.experimental.stepvector.nxv3i16()

define <vscale x 3 x i16> @stepvector_nxv3i16() {
; CHECK-LABEL: stepvector_nxv3i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 3 x i16> @llvm.experimental.stepvector.nxv3i16()
  ret <vscale x 3 x i16> %v
}

declare <vscale x 4 x i16> @llvm.experimental.stepvector.nxv4i16()

define <vscale x 4 x i16> @stepvector_nxv4i16() {
; CHECK-LABEL: stepvector_nxv4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i16> @llvm.experimental.stepvector.nxv4i16()
  ret <vscale x 4 x i16> %v
}

declare <vscale x 8 x i16> @llvm.experimental.stepvector.nxv8i16()

define <vscale x 8 x i16> @stepvector_nxv8i16() {
; CHECK-LABEL: stepvector_nxv8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i16> @llvm.experimental.stepvector.nxv8i16()
  ret <vscale x 8 x i16> %v
}

declare <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()

define <vscale x 16 x i16> @stepvector_nxv16i16() {
; CHECK-LABEL: stepvector_nxv16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()
  ret <vscale x 16 x i16> %v
}

define <vscale x 16 x i16> @add_stepvector_nxv16i16() {
; CHECK-LABEL: add_stepvector_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vv v8, v8, v8
; CHECK-NEXT:    ret
entry:
  %0 = call <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()
  %1 = call <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()
  %2 = add <vscale x 16 x i16> %0, %1
  ret <vscale x 16 x i16> %2
}

define <vscale x 16 x i16> @mul_stepvector_nxv16i16() {
; CHECK-LABEL: mul_stepvector_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    li a0, 3
; CHECK-NEXT:    vmul.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i16> poison, i16 3, i32 0
  %1 = shufflevector <vscale x 16 x i16> %0, <vscale x 16 x i16> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()
  %3 = mul <vscale x 16 x i16> %2, %1
  ret <vscale x 16 x i16> %3
}

define <vscale x 16 x i16> @shl_stepvector_nxv16i16() {
; CHECK-LABEL: shl_stepvector_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsll.vi v8, v8, 2
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i16> poison, i16 2, i32 0
  %1 = shufflevector <vscale x 16 x i16> %0, <vscale x 16 x i16> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i16> @llvm.experimental.stepvector.nxv16i16()
  %3 = shl <vscale x 16 x i16> %2, %1
  ret <vscale x 16 x i16> %3
}

declare <vscale x 32 x i16> @llvm.experimental.stepvector.nxv32i16()

define <vscale x 32 x i16> @stepvector_nxv32i16() {
; CHECK-LABEL: stepvector_nxv32i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x i16> @llvm.experimental.stepvector.nxv32i16()
  ret <vscale x 32 x i16> %v
}

declare <vscale x 1 x i32> @llvm.experimental.stepvector.nxv1i32()

define <vscale x 1 x i32> @stepvector_nxv1i32() {
; CHECK-LABEL: stepvector_nxv1i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i32> @llvm.experimental.stepvector.nxv1i32()
  ret <vscale x 1 x i32> %v
}

declare <vscale x 2 x i32> @llvm.experimental.stepvector.nxv2i32()

define <vscale x 2 x i32> @stepvector_nxv2i32() {
; CHECK-LABEL: stepvector_nxv2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i32> @llvm.experimental.stepvector.nxv2i32()
  ret <vscale x 2 x i32> %v
}

declare <vscale x 3 x i32> @llvm.experimental.stepvector.nxv3i32()

define <vscale x 3 x i32> @stepvector_nxv3i32() {
; CHECK-LABEL: stepvector_nxv3i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 3 x i32> @llvm.experimental.stepvector.nxv3i32()
  ret <vscale x 3 x i32> %v
}

declare <vscale x 4 x i32> @llvm.experimental.stepvector.nxv4i32()

define <vscale x 4 x i32> @stepvector_nxv4i32() {
; CHECK-LABEL: stepvector_nxv4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i32> @llvm.experimental.stepvector.nxv4i32()
  ret <vscale x 4 x i32> %v
}

declare <vscale x 8 x i32> @llvm.experimental.stepvector.nxv8i32()

define <vscale x 8 x i32> @stepvector_nxv8i32() {
; CHECK-LABEL: stepvector_nxv8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i32> @llvm.experimental.stepvector.nxv8i32()
  ret <vscale x 8 x i32> %v
}

declare <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()

define <vscale x 16 x i32> @stepvector_nxv16i32() {
; CHECK-LABEL: stepvector_nxv16i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()
  ret <vscale x 16 x i32> %v
}

define <vscale x 16 x i32> @add_stepvector_nxv16i32() {
; CHECK-LABEL: add_stepvector_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vv v8, v8, v8
; CHECK-NEXT:    ret
entry:
  %0 = call <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()
  %1 = call <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()
  %2 = add <vscale x 16 x i32> %0, %1
  ret <vscale x 16 x i32> %2
}

define <vscale x 16 x i32> @mul_stepvector_nxv16i32() {
; CHECK-LABEL: mul_stepvector_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    li a0, 3
; CHECK-NEXT:    vmul.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i32> poison, i32 3, i32 0
  %1 = shufflevector <vscale x 16 x i32> %0, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()
  %3 = mul <vscale x 16 x i32> %2, %1
  ret <vscale x 16 x i32> %3
}

define <vscale x 16 x i32> @shl_stepvector_nxv16i32() {
; CHECK-LABEL: shl_stepvector_nxv16i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsll.vi v8, v8, 2
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i32> poison, i32 2, i32 0
  %1 = shufflevector <vscale x 16 x i32> %0, <vscale x 16 x i32> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i32> @llvm.experimental.stepvector.nxv16i32()
  %3 = shl <vscale x 16 x i32> %2, %1
  ret <vscale x 16 x i32> %3
}

declare <vscale x 1 x i64> @llvm.experimental.stepvector.nxv1i64()

define <vscale x 1 x i64> @stepvector_nxv1i64() {
; CHECK-LABEL: stepvector_nxv1i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x i64> @llvm.experimental.stepvector.nxv1i64()
  ret <vscale x 1 x i64> %v
}

declare <vscale x 2 x i64> @llvm.experimental.stepvector.nxv2i64()

define <vscale x 2 x i64> @stepvector_nxv2i64() {
; CHECK-LABEL: stepvector_nxv2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x i64> @llvm.experimental.stepvector.nxv2i64()
  ret <vscale x 2 x i64> %v
}

declare <vscale x 3 x i64> @llvm.experimental.stepvector.nxv3i64()

define <vscale x 3 x i64> @stepvector_nxv3i64() {
; CHECK-LABEL: stepvector_nxv3i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 3 x i64> @llvm.experimental.stepvector.nxv3i64()
  ret <vscale x 3 x i64> %v
}

declare <vscale x 4 x i64> @llvm.experimental.stepvector.nxv4i64()

define <vscale x 4 x i64> @stepvector_nxv4i64() {
; CHECK-LABEL: stepvector_nxv4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x i64> @llvm.experimental.stepvector.nxv4i64()
  ret <vscale x 4 x i64> %v
}

declare <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()

define <vscale x 8 x i64> @stepvector_nxv8i64() {
; CHECK-LABEL: stepvector_nxv8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  ret <vscale x 8 x i64> %v
}

define <vscale x 8 x i64> @add_stepvector_nxv8i64() {
; CHECK-LABEL: add_stepvector_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vadd.vv v8, v8, v8
; CHECK-NEXT:    ret
entry:
  %0 = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  %1 = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  %2 = add <vscale x 8 x i64> %0, %1
  ret <vscale x 8 x i64> %2
}

define <vscale x 8 x i64> @mul_stepvector_nxv8i64() {
; CHECK-LABEL: mul_stepvector_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    li a0, 3
; CHECK-NEXT:    vmul.vx v8, v8, a0
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 8 x i64> poison, i64 3, i32 0
  %1 = shufflevector <vscale x 8 x i64> %0, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %2 = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  %3 = mul <vscale x 8 x i64> %2, %1
  ret <vscale x 8 x i64> %3
}

define <vscale x 8 x i64> @mul_bigimm_stepvector_nxv8i64() {
; RV32-LABEL: mul_bigimm_stepvector_nxv8i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    li a0, 7
; RV32-NEXT:    sw a0, 12(sp)
; RV32-NEXT:    lui a0, 797989
; RV32-NEXT:    addi a0, a0, -683
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV32-NEXT:    vlse64.v v8, (a0), zero
; RV32-NEXT:    vid.v v16
; RV32-NEXT:    vmul.vv v8, v16, v8
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: mul_bigimm_stepvector_nxv8i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    lui a0, 1987
; RV64-NEXT:    addiw a0, a0, -731
; RV64-NEXT:    slli a0, a0, 12
; RV64-NEXT:    addi a0, a0, -683
; RV64-NEXT:    vmul.vx v8, v8, a0
; RV64-NEXT:    ret
entry:
  %0 = insertelement <vscale x 8 x i64> poison, i64 33333333333, i32 0
  %1 = shufflevector <vscale x 8 x i64> %0, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %2 = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  %3 = mul <vscale x 8 x i64> %2, %1
  ret <vscale x 8 x i64> %3
}

define <vscale x 8 x i64> @shl_stepvector_nxv8i64() {
; CHECK-LABEL: shl_stepvector_nxv8i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    vsll.vi v8, v8, 2
; CHECK-NEXT:    ret
entry:
  %0 = insertelement <vscale x 8 x i64> poison, i64 2, i32 0
  %1 = shufflevector <vscale x 8 x i64> %0, <vscale x 8 x i64> poison, <vscale x 8 x i32> zeroinitializer
  %2 = call <vscale x 8 x i64> @llvm.experimental.stepvector.nxv8i64()
  %3 = shl <vscale x 8 x i64> %2, %1
  ret <vscale x 8 x i64> %3
}

declare <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()

define <vscale x 16 x i64> @stepvector_nxv16i64() {
; RV32-LABEL: stepvector_nxv16i64:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw zero, 12(sp)
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV32-NEXT:    vlse64.v v16, (a0), zero
; RV32-NEXT:    vid.v v8
; RV32-NEXT:    vadd.vv v16, v8, v16
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: stepvector_nxv16i64:
; RV64:       # %bb.0:
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    vadd.vx v16, v8, a0
; RV64-NEXT:    ret
  %v = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  ret <vscale x 16 x i64> %v
}

define <vscale x 16 x i64> @add_stepvector_nxv16i64() {
; RV32-LABEL: add_stepvector_nxv16i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw zero, 12(sp)
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 1
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vlse64.v v16, (a0), zero
; RV32-NEXT:    vid.v v8
; RV32-NEXT:    vadd.vv v8, v8, v8
; RV32-NEXT:    vadd.vv v16, v8, v16
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: add_stepvector_nxv16i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    slli a0, a0, 1
; RV64-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    vadd.vv v8, v8, v8
; RV64-NEXT:    vadd.vx v16, v8, a0
; RV64-NEXT:    ret
entry:
  %0 = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  %1 = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  %2 = add <vscale x 16 x i64> %0, %1
  ret <vscale x 16 x i64> %2
}

define <vscale x 16 x i64> @mul_stepvector_nxv16i64() {
; RV32-LABEL: mul_stepvector_nxv16i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw zero, 12(sp)
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a1, a0, 1
; RV32-NEXT:    add a0, a1, a0
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vlse64.v v16, (a0), zero
; RV32-NEXT:    vid.v v8
; RV32-NEXT:    li a0, 3
; RV32-NEXT:    vmul.vx v8, v8, a0
; RV32-NEXT:    vadd.vv v16, v8, v16
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: mul_stepvector_nxv16i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    li a0, 3
; RV64-NEXT:    vmul.vx v8, v8, a0
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    slli a1, a0, 1
; RV64-NEXT:    add a0, a1, a0
; RV64-NEXT:    vadd.vx v16, v8, a0
; RV64-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i64> poison, i64 3, i32 0
  %1 = shufflevector <vscale x 16 x i64> %0, <vscale x 16 x i64> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  %3 = mul <vscale x 16 x i64> %2, %1
  ret <vscale x 16 x i64> %3
}

define <vscale x 16 x i64> @mul_bigimm_stepvector_nxv16i64() {
; RV32-LABEL: mul_bigimm_stepvector_nxv16i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    li a0, 7
; RV32-NEXT:    sw a0, 12(sp)
; RV32-NEXT:    lui a0, 797989
; RV32-NEXT:    addi a0, a0, -683
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    lui a1, 11557
; RV32-NEXT:    addi a1, a1, -683
; RV32-NEXT:    mul a1, a0, a1
; RV32-NEXT:    sw a1, 0(sp)
; RV32-NEXT:    srli a0, a0, 3
; RV32-NEXT:    li a1, 62
; RV32-NEXT:    mul a1, a0, a1
; RV32-NEXT:    lui a2, 92455
; RV32-NEXT:    addi a2, a2, -1368
; RV32-NEXT:    mulhu a0, a0, a2
; RV32-NEXT:    add a0, a0, a1
; RV32-NEXT:    sw a0, 4(sp)
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV32-NEXT:    vlse64.v v8, (a0), zero
; RV32-NEXT:    mv a0, sp
; RV32-NEXT:    vlse64.v v16, (a0), zero
; RV32-NEXT:    vid.v v24
; RV32-NEXT:    vmul.vv v8, v24, v8
; RV32-NEXT:    vadd.vv v16, v8, v16
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: mul_bigimm_stepvector_nxv16i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    lui a1, 1987
; RV64-NEXT:    addiw a1, a1, -731
; RV64-NEXT:    slli a1, a1, 12
; RV64-NEXT:    addi a1, a1, -683
; RV64-NEXT:    mul a0, a0, a1
; RV64-NEXT:    vsetvli a2, zero, e64, m8, ta, ma
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    vmul.vx v8, v8, a1
; RV64-NEXT:    vadd.vx v16, v8, a0
; RV64-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i64> poison, i64 33333333333, i32 0
  %1 = shufflevector <vscale x 16 x i64> %0, <vscale x 16 x i64> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  %3 = mul <vscale x 16 x i64> %2, %1
  ret <vscale x 16 x i64> %3
}

define <vscale x 16 x i64> @shl_stepvector_nxv16i64() {
; RV32-LABEL: shl_stepvector_nxv16i64:
; RV32:       # %bb.0: # %entry
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    .cfi_def_cfa_offset 16
; RV32-NEXT:    sw zero, 12(sp)
; RV32-NEXT:    csrr a0, vlenb
; RV32-NEXT:    slli a0, a0, 2
; RV32-NEXT:    sw a0, 8(sp)
; RV32-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; RV32-NEXT:    addi a0, sp, 8
; RV32-NEXT:    vlse64.v v16, (a0), zero
; RV32-NEXT:    vid.v v8
; RV32-NEXT:    vsll.vi v8, v8, 2
; RV32-NEXT:    vadd.vv v16, v8, v16
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: shl_stepvector_nxv16i64:
; RV64:       # %bb.0: # %entry
; RV64-NEXT:    csrr a0, vlenb
; RV64-NEXT:    slli a0, a0, 2
; RV64-NEXT:    vsetvli a1, zero, e64, m8, ta, ma
; RV64-NEXT:    vid.v v8
; RV64-NEXT:    vsll.vi v8, v8, 2
; RV64-NEXT:    vadd.vx v16, v8, a0
; RV64-NEXT:    ret
entry:
  %0 = insertelement <vscale x 16 x i64> poison, i64 2, i32 0
  %1 = shufflevector <vscale x 16 x i64> %0, <vscale x 16 x i64> poison, <vscale x 16 x i32> zeroinitializer
  %2 = call <vscale x 16 x i64> @llvm.experimental.stepvector.nxv16i64()
  %3 = shl <vscale x 16 x i64> %2, %1
  ret <vscale x 16 x i64> %3
}
