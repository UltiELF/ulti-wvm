; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfhmin,+zvfhmin,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfhmin,+zvfhmin,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN

declare <vscale x 1 x half> @llvm.vp.fneg.nxv1f16(<vscale x 1 x half>, <vscale x 1 x i1>, i32)

define <vscale x 1 x half> @vfneg_vv_nxv1f16(<vscale x 1 x half> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v9, v9, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 1 x half> @llvm.vp.fneg.nxv1f16(<vscale x 1 x half> %va, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x half> %v
}

define <vscale x 1 x half> @vfneg_vv_nxv1f16_unmasked(<vscale x 1 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv1f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv1f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v9, v9
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 1 x i1> %head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x half> @llvm.vp.fneg.nxv1f16(<vscale x 1 x half> %va, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.fneg.nxv2f16(<vscale x 2 x half>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vfneg_vv_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v9, v9, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.fneg.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vfneg_vv_nxv2f16_unmasked(<vscale x 2 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv2f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv2f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v9, v9
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 2 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 2 x i1> %head, <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x half> @llvm.vp.fneg.nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 4 x half> @llvm.vp.fneg.nxv4f16(<vscale x 4 x half>, <vscale x 4 x i1>, i32)

define <vscale x 4 x half> @vfneg_vv_nxv4f16(<vscale x 4 x half> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v10, v10, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 4 x half> @llvm.vp.fneg.nxv4f16(<vscale x 4 x half> %va, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x half> %v
}

define <vscale x 4 x half> @vfneg_vv_nxv4f16_unmasked(<vscale x 4 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv4f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv4f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v10, v10
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 4 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 4 x i1> %head, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x half> @llvm.vp.fneg.nxv4f16(<vscale x 4 x half> %va, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x half> %v
}

declare <vscale x 8 x half> @llvm.vp.fneg.nxv8f16(<vscale x 8 x half>, <vscale x 8 x i1>, i32)

define <vscale x 8 x half> @vfneg_vv_nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v12, v12, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 8 x half> @llvm.vp.fneg.nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x half> %v
}

define <vscale x 8 x half> @vfneg_vv_nxv8f16_unmasked(<vscale x 8 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv8f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv8f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v12, v12
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 8 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 8 x i1> %head, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x half> @llvm.vp.fneg.nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x half> %v
}

declare <vscale x 16 x half> @llvm.vp.fneg.nxv16f16(<vscale x 16 x half>, <vscale x 16 x i1>, i32)

define <vscale x 16 x half> @vfneg_vv_nxv16f16(<vscale x 16 x half> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v16, v16, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 16 x half> @llvm.vp.fneg.nxv16f16(<vscale x 16 x half> %va, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x half> %v
}

define <vscale x 16 x half> @vfneg_vv_nxv16f16_unmasked(<vscale x 16 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv16f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv16f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v16, v16
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 16 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 16 x i1> %head, <vscale x 16 x i1> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x half> @llvm.vp.fneg.nxv16f16(<vscale x 16 x half> %va, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x half> %v
}

declare <vscale x 32 x half> @llvm.vp.fneg.nxv32f16(<vscale x 32 x half>, <vscale x 32 x i1>, i32)

define <vscale x 32 x half> @vfneg_vv_nxv32f16(<vscale x 32 x half> %va, <vscale x 32 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv32f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8, v0.t
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv32f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vmv1r.v v16, v0
; ZVFHMIN-NEXT:    csrr a2, vlenb
; ZVFHMIN-NEXT:    slli a1, a2, 1
; ZVFHMIN-NEXT:    sub a3, a0, a1
; ZVFHMIN-NEXT:    sltu a4, a0, a3
; ZVFHMIN-NEXT:    addi a4, a4, -1
; ZVFHMIN-NEXT:    and a3, a4, a3
; ZVFHMIN-NEXT:    srli a2, a2, 2
; ZVFHMIN-NEXT:    vsetvli a4, zero, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v0, v0, a2
; ZVFHMIN-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    vsetvli zero, a3, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v24, v24, v0.t
; ZVFHMIN-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v24
; ZVFHMIN-NEXT:    bltu a0, a1, .LBB10_2
; ZVFHMIN-NEXT:  # %bb.1:
; ZVFHMIN-NEXT:    mv a0, a1
; ZVFHMIN-NEXT:  .LBB10_2:
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vmv1r.v v0, v16
; ZVFHMIN-NEXT:    vfneg.v v16, v24, v0.t
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %v = call <vscale x 32 x half> @llvm.vp.fneg.nxv32f16(<vscale x 32 x half> %va, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x half> %v
}

define <vscale x 32 x half> @vfneg_vv_nxv32f16_unmasked(<vscale x 32 x half> %va, i32 zeroext %evl) {
; ZVFH-LABEL: vfneg_vv_nxv32f16_unmasked:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; ZVFH-NEXT:    vfneg.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfneg_vv_nxv32f16_unmasked:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e8, m4, ta, ma
; ZVFHMIN-NEXT:    vmset.m v16
; ZVFHMIN-NEXT:    csrr a2, vlenb
; ZVFHMIN-NEXT:    slli a1, a2, 1
; ZVFHMIN-NEXT:    sub a3, a0, a1
; ZVFHMIN-NEXT:    sltu a4, a0, a3
; ZVFHMIN-NEXT:    addi a4, a4, -1
; ZVFHMIN-NEXT:    and a3, a4, a3
; ZVFHMIN-NEXT:    srli a2, a2, 2
; ZVFHMIN-NEXT:    vsetvli a4, zero, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v0, v16, a2
; ZVFHMIN-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, a3, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v16, v16, v0.t
; ZVFHMIN-NEXT:    vsetvli a2, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v16
; ZVFHMIN-NEXT:    bltu a0, a1, .LBB11_2
; ZVFHMIN-NEXT:  # %bb.1:
; ZVFHMIN-NEXT:    mv a0, a1
; ZVFHMIN-NEXT:  .LBB11_2:
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfneg.v v16, v16
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 32 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 32 x i1> %head, <vscale x 32 x i1> poison, <vscale x 32 x i32> zeroinitializer
  %v = call <vscale x 32 x half> @llvm.vp.fneg.nxv32f16(<vscale x 32 x half> %va, <vscale x 32 x i1> %m, i32 %evl)
  ret <vscale x 32 x half> %v
}

declare <vscale x 1 x float> @llvm.vp.fneg.nxv1f32(<vscale x 1 x float>, <vscale x 1 x i1>, i32)

define <vscale x 1 x float> @vfneg_vv_nxv1f32(<vscale x 1 x float> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x float> @llvm.vp.fneg.nxv1f32(<vscale x 1 x float> %va, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x float> %v
}

define <vscale x 1 x float> @vfneg_vv_nxv1f32_unmasked(<vscale x 1 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv1f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 1 x i1> %head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x float> @llvm.vp.fneg.nxv1f32(<vscale x 1 x float> %va, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x float> %v
}

declare <vscale x 2 x float> @llvm.vp.fneg.nxv2f32(<vscale x 2 x float>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vfneg_vv_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.fneg.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vfneg_vv_nxv2f32_unmasked(<vscale x 2 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 2 x i1> %head, <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x float> @llvm.vp.fneg.nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 4 x float> @llvm.vp.fneg.nxv4f32(<vscale x 4 x float>, <vscale x 4 x i1>, i32)

define <vscale x 4 x float> @vfneg_vv_nxv4f32(<vscale x 4 x float> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x float> @llvm.vp.fneg.nxv4f32(<vscale x 4 x float> %va, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x float> %v
}

define <vscale x 4 x float> @vfneg_vv_nxv4f32_unmasked(<vscale x 4 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv4f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 4 x i1> %head, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x float> @llvm.vp.fneg.nxv4f32(<vscale x 4 x float> %va, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x float> %v
}

declare <vscale x 8 x float> @llvm.vp.fneg.nxv8f32(<vscale x 8 x float>, <vscale x 8 x i1>, i32)

define <vscale x 8 x float> @vfneg_vv_nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x float> @llvm.vp.fneg.nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x float> %v
}

define <vscale x 8 x float> @vfneg_vv_nxv8f32_unmasked(<vscale x 8 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv8f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 8 x i1> %head, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x float> @llvm.vp.fneg.nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x float> %v
}

declare <vscale x 16 x float> @llvm.vp.fneg.nxv16f32(<vscale x 16 x float>, <vscale x 16 x i1>, i32)

define <vscale x 16 x float> @vfneg_vv_nxv16f32(<vscale x 16 x float> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x float> @llvm.vp.fneg.nxv16f32(<vscale x 16 x float> %va, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x float> %v
}

define <vscale x 16 x float> @vfneg_vv_nxv16f32_unmasked(<vscale x 16 x float> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv16f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 16 x i1> %head, <vscale x 16 x i1> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x float> @llvm.vp.fneg.nxv16f32(<vscale x 16 x float> %va, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x float> %v
}

declare <vscale x 1 x double> @llvm.vp.fneg.nxv1f64(<vscale x 1 x double>, <vscale x 1 x i1>, i32)

define <vscale x 1 x double> @vfneg_vv_nxv1f64(<vscale x 1 x double> %va, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 1 x double> @llvm.vp.fneg.nxv1f64(<vscale x 1 x double> %va, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x double> %v
}

define <vscale x 1 x double> @vfneg_vv_nxv1f64_unmasked(<vscale x 1 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv1f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 1 x i1> %head, <vscale x 1 x i1> poison, <vscale x 1 x i32> zeroinitializer
  %v = call <vscale x 1 x double> @llvm.vp.fneg.nxv1f64(<vscale x 1 x double> %va, <vscale x 1 x i1> %m, i32 %evl)
  ret <vscale x 1 x double> %v
}

declare <vscale x 2 x double> @llvm.vp.fneg.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i32)

define <vscale x 2 x double> @vfneg_vv_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x double> @llvm.vp.fneg.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

define <vscale x 2 x double> @vfneg_vv_nxv2f64_unmasked(<vscale x 2 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 2 x i1> %head, <vscale x 2 x i1> poison, <vscale x 2 x i32> zeroinitializer
  %v = call <vscale x 2 x double> @llvm.vp.fneg.nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x i1> %m, i32 %evl)
  ret <vscale x 2 x double> %v
}

declare <vscale x 4 x double> @llvm.vp.fneg.nxv4f64(<vscale x 4 x double>, <vscale x 4 x i1>, i32)

define <vscale x 4 x double> @vfneg_vv_nxv4f64(<vscale x 4 x double> %va, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 4 x double> @llvm.vp.fneg.nxv4f64(<vscale x 4 x double> %va, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x double> %v
}

define <vscale x 4 x double> @vfneg_vv_nxv4f64_unmasked(<vscale x 4 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv4f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 4 x i1> %head, <vscale x 4 x i1> poison, <vscale x 4 x i32> zeroinitializer
  %v = call <vscale x 4 x double> @llvm.vp.fneg.nxv4f64(<vscale x 4 x double> %va, <vscale x 4 x i1> %m, i32 %evl)
  ret <vscale x 4 x double> %v
}

declare <vscale x 7 x double> @llvm.vp.fneg.nxv7f64(<vscale x 7 x double>, <vscale x 7 x i1>, i32)

define <vscale x 7 x double> @vfneg_vv_nxv7f64(<vscale x 7 x double> %va, <vscale x 7 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv7f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 7 x double> @llvm.vp.fneg.nxv7f64(<vscale x 7 x double> %va, <vscale x 7 x i1> %m, i32 %evl)
  ret <vscale x 7 x double> %v
}

define <vscale x 7 x double> @vfneg_vv_nxv7f64_unmasked(<vscale x 7 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv7f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 7 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 7 x i1> %head, <vscale x 7 x i1> poison, <vscale x 7 x i32> zeroinitializer
  %v = call <vscale x 7 x double> @llvm.vp.fneg.nxv7f64(<vscale x 7 x double> %va, <vscale x 7 x i1> %m, i32 %evl)
  ret <vscale x 7 x double> %v
}

declare <vscale x 8 x double> @llvm.vp.fneg.nxv8f64(<vscale x 8 x double>, <vscale x 8 x i1>, i32)

define <vscale x 8 x double> @vfneg_vv_nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 8 x double> @llvm.vp.fneg.nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x double> %v
}

define <vscale x 8 x double> @vfneg_vv_nxv8f64_unmasked(<vscale x 8 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv8f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 8 x i1> %head, <vscale x 8 x i1> poison, <vscale x 8 x i32> zeroinitializer
  %v = call <vscale x 8 x double> @llvm.vp.fneg.nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x i1> %m, i32 %evl)
  ret <vscale x 8 x double> %v
}

; Test splitting.
declare <vscale x 16 x double> @llvm.vp.fneg.nxv16f64(<vscale x 16 x double>, <vscale x 16 x i1>, i32)

define <vscale x 16 x double> @vfneg_vv_nxv16f64(<vscale x 16 x double> %va, <vscale x 16 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vmv1r.v v24, v0
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 3
; CHECK-NEXT:    vsetvli a3, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vfneg.v v16, v16, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB32_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB32_2:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v24
; CHECK-NEXT:    vfneg.v v8, v8, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x double> @llvm.vp.fneg.nxv16f64(<vscale x 16 x double> %va, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x double> %v
}

define <vscale x 16 x double> @vfneg_vv_nxv16f64_unmasked(<vscale x 16 x double> %va, i32 zeroext %evl) {
; CHECK-LABEL: vfneg_vv_nxv16f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vfneg.v v16, v16
; CHECK-NEXT:    bltu a0, a1, .LBB33_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB33_2:
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vfneg.v v8, v8
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x i1> poison, i1 true, i32 0
  %m = shufflevector <vscale x 16 x i1> %head, <vscale x 16 x i1> poison, <vscale x 16 x i32> zeroinitializer
  %v = call <vscale x 16 x double> @llvm.vp.fneg.nxv16f64(<vscale x 16 x double> %va, <vscale x 16 x i1> %m, i32 %evl)
  ret <vscale x 16 x double> %v
}
