; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+m,+d,+zfhmin,+zvfhmin,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+m,+d,+zfhmin,+zvfhmin,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN

; This tests a mix of vfmacc and vfmadd by using different operand orders to
; trigger commuting in TwoAddressInstructionPass.

declare <vscale x 1 x half> @llvm.fma.v1f16(<vscale x 1 x half>, <vscale x 1 x half>, <vscale x 1 x half>)

define <vscale x 1 x half> @vfmadd_vv_nxv1f16(<vscale x 1 x half> %va, <vscale x 1 x half> %vb, <vscale x 1 x half> %vc) {
; ZVFH-LABEL: vfmadd_vv_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFH-NEXT:    vfmadd.vv v8, v9, v10
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vv_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v11, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v12, v10, v11
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %vd = call <vscale x 1 x half> @llvm.fma.v1f16(<vscale x 1 x half> %va, <vscale x 1 x half> %vb, <vscale x 1 x half> %vc)
  ret <vscale x 1 x half> %vd
}

define <vscale x 1 x half> @vfmadd_vf_nxv1f16(<vscale x 1 x half> %va, <vscale x 1 x half> %vb, half %c) {
; ZVFH-LABEL: vfmadd_vf_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFH-NEXT:    vfmadd.vf v8, fa0, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vf_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v10, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v11, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v11
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v12, v9, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 1 x half> poison, half %c, i32 0
  %splat = shufflevector <vscale x 1 x half> %head, <vscale x 1 x half> poison, <vscale x 1 x i32> zeroinitializer
  %vd = call <vscale x 1 x half> @llvm.fma.v1f16(<vscale x 1 x half> %va, <vscale x 1 x half> %splat, <vscale x 1 x half> %vb)
  ret <vscale x 1 x half> %vd
}

declare <vscale x 2 x half> @llvm.fma.v2f16(<vscale x 2 x half>, <vscale x 2 x half>, <vscale x 2 x half>)

define <vscale x 2 x half> @vfmadd_vv_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x half> %vb, <vscale x 2 x half> %vc) {
; ZVFH-LABEL: vfmadd_vv_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfmadd.vv v8, v10, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vv_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v11, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v12, v9, v11
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %vd = call <vscale x 2 x half> @llvm.fma.v2f16(<vscale x 2 x half> %va, <vscale x 2 x half> %vc, <vscale x 2 x half> %vb)
  ret <vscale x 2 x half> %vd
}

define <vscale x 2 x half> @vfmadd_vf_nxv2f16(<vscale x 2 x half> %va, <vscale x 2 x half> %vb, half %c) {
; ZVFH-LABEL: vfmadd_vf_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfmacc.vf v8, fa0, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vf_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v10, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v11, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v11
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v9, v8, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 2 x half> poison, half %c, i32 0
  %splat = shufflevector <vscale x 2 x half> %head, <vscale x 2 x half> poison, <vscale x 2 x i32> zeroinitializer
  %vd = call <vscale x 2 x half> @llvm.fma.v2f16(<vscale x 2 x half> %vb, <vscale x 2 x half> %splat, <vscale x 2 x half> %va)
  ret <vscale x 2 x half> %vd
}

declare <vscale x 4 x half> @llvm.fma.v4f16(<vscale x 4 x half>, <vscale x 4 x half>, <vscale x 4 x half>)

define <vscale x 4 x half> @vfmadd_vv_nxv4f16(<vscale x 4 x half> %va, <vscale x 4 x half> %vb, <vscale x 4 x half> %vc) {
; ZVFH-LABEL: vfmadd_vv_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFH-NEXT:    vfmadd.vv v8, v9, v10
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vv_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v14, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v14, v10, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v14
; ZVFHMIN-NEXT:    ret
  %vd = call <vscale x 4 x half> @llvm.fma.v4f16(<vscale x 4 x half> %vb, <vscale x 4 x half> %va, <vscale x 4 x half> %vc)
  ret <vscale x 4 x half> %vd
}

define <vscale x 4 x half> @vfmadd_vf_nxv4f16(<vscale x 4 x half> %va, <vscale x 4 x half> %vb, half %c) {
; ZVFH-LABEL: vfmadd_vf_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFH-NEXT:    vfmadd.vf v8, fa0, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vf_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v10, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v9
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v14, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v16, v14, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 4 x half> poison, half %c, i32 0
  %splat = shufflevector <vscale x 4 x half> %head, <vscale x 4 x half> poison, <vscale x 4 x i32> zeroinitializer
  %vd = call <vscale x 4 x half> @llvm.fma.v4f16(<vscale x 4 x half> %va, <vscale x 4 x half> %splat, <vscale x 4 x half> %vb)
  ret <vscale x 4 x half> %vd
}

declare <vscale x 8 x half> @llvm.fma.v8f16(<vscale x 8 x half>, <vscale x 8 x half>, <vscale x 8 x half>)

define <vscale x 8 x half> @vfmadd_vv_nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x half> %vb, <vscale x 8 x half> %vc) {
; ZVFH-LABEL: vfmadd_vv_nxv8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfmacc.vv v8, v12, v10
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vv_nxv8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v20, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v24, v20, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v24
; ZVFHMIN-NEXT:    ret
  %vd = call <vscale x 8 x half> @llvm.fma.v8f16(<vscale x 8 x half> %vb, <vscale x 8 x half> %vc, <vscale x 8 x half> %va)
  ret <vscale x 8 x half> %vd
}

define <vscale x 8 x half> @vfmadd_vf_nxv8f16(<vscale x 8 x half> %va, <vscale x 8 x half> %vb, half %c) {
; ZVFH-LABEL: vfmadd_vf_nxv8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfmacc.vf v8, fa0, v10
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vf_nxv8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v12, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v16, v12
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v20, v10
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v24, v20, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v24
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 8 x half> poison, half %c, i32 0
  %splat = shufflevector <vscale x 8 x half> %head, <vscale x 8 x half> poison, <vscale x 8 x i32> zeroinitializer
  %vd = call <vscale x 8 x half> @llvm.fma.v8f16(<vscale x 8 x half> %vb, <vscale x 8 x half> %splat, <vscale x 8 x half> %va)
  ret <vscale x 8 x half> %vd
}

declare <vscale x 16 x half> @llvm.fma.v16f16(<vscale x 16 x half>, <vscale x 16 x half>, <vscale x 16 x half>)

define <vscale x 16 x half> @vfmadd_vv_nxv16f16(<vscale x 16 x half> %va, <vscale x 16 x half> %vb, <vscale x 16 x half> %vc) {
; ZVFH-LABEL: vfmadd_vv_nxv16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFH-NEXT:    vfmadd.vv v8, v16, v12
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vv_nxv16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v0, v16
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v16, v0, v24
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %vd = call <vscale x 16 x half> @llvm.fma.v16f16(<vscale x 16 x half> %vc, <vscale x 16 x half> %va, <vscale x 16 x half> %vb)
  ret <vscale x 16 x half> %vd
}

define <vscale x 16 x half> @vfmadd_vf_nxv16f16(<vscale x 16 x half> %va, <vscale x 16 x half> %vb, half %c) {
; ZVFH-LABEL: vfmadd_vf_nxv16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFH-NEXT:    vfmadd.vf v8, fa0, v12
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vf_nxv16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    addi sp, sp, -16
; ZVFHMIN-NEXT:    .cfi_def_cfa_offset 16
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 2
; ZVFHMIN-NEXT:    sub sp, sp, a0
; ZVFHMIN-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x04, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 4 * vlenb
; ZVFHMIN-NEXT:    vmv4r.v v28, v12
; ZVFHMIN-NEXT:    addi a0, sp, 16
; ZVFHMIN-NEXT:    vs4r.v v8, (a0) # Unknown-size Folded Spill
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v16, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v24, v16
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v28
; ZVFHMIN-NEXT:    addi a0, sp, 16
; ZVFHMIN-NEXT:    vl4r.v v16, (a0) # Unknown-size Folded Reload
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v0, v16
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v24
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v16, v0, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 2
; ZVFHMIN-NEXT:    add sp, sp, a0
; ZVFHMIN-NEXT:    addi sp, sp, 16
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 16 x half> poison, half %c, i32 0
  %splat = shufflevector <vscale x 16 x half> %head, <vscale x 16 x half> poison, <vscale x 16 x i32> zeroinitializer
  %vd = call <vscale x 16 x half> @llvm.fma.v16f16(<vscale x 16 x half> %va, <vscale x 16 x half> %splat, <vscale x 16 x half> %vb)
  ret <vscale x 16 x half> %vd
}

declare <vscale x 32 x half> @llvm.fma.v32f16(<vscale x 32 x half>, <vscale x 32 x half>, <vscale x 32 x half>)

define <vscale x 32 x half> @vfmadd_vv_nxv32f16(<vscale x 32 x half> %va, <vscale x 32 x half> %vb, <vscale x 32 x half> %vc) {
; ZVFH-LABEL: vfmadd_vv_nxv32f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vl8re16.v v24, (a0)
; ZVFH-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; ZVFH-NEXT:    vfmacc.vv v8, v16, v24
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vv_nxv32f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    addi sp, sp, -16
; ZVFHMIN-NEXT:    .cfi_def_cfa_offset 16
; ZVFHMIN-NEXT:    csrr a1, vlenb
; ZVFHMIN-NEXT:    li a2, 40
; ZVFHMIN-NEXT:    mul a1, a1, a2
; ZVFHMIN-NEXT:    sub sp, sp, a1
; ZVFHMIN-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x28, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 40 * vlenb
; ZVFHMIN-NEXT:    csrr a1, vlenb
; ZVFHMIN-NEXT:    slli a1, a1, 3
; ZVFHMIN-NEXT:    add a1, sp, a1
; ZVFHMIN-NEXT:    addi a1, a1, 16
; ZVFHMIN-NEXT:    vs8r.v v16, (a1) # Unknown-size Folded Spill
; ZVFHMIN-NEXT:    vmv8r.v v0, v8
; ZVFHMIN-NEXT:    csrr a1, vlenb
; ZVFHMIN-NEXT:    li a2, 24
; ZVFHMIN-NEXT:    mul a1, a1, a2
; ZVFHMIN-NEXT:    add a1, sp, a1
; ZVFHMIN-NEXT:    addi a1, a1, 16
; ZVFHMIN-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; ZVFHMIN-NEXT:    vl8re16.v v24, (a0)
; ZVFHMIN-NEXT:    addi a0, sp, 16
; ZVFHMIN-NEXT:    vs8r.v v24, (a0) # Unknown-size Folded Spill
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v0
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 5
; ZVFHMIN-NEXT:    add a0, sp, a0
; ZVFHMIN-NEXT:    addi a0, a0, 16
; ZVFHMIN-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v16
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 4
; ZVFHMIN-NEXT:    add a0, sp, a0
; ZVFHMIN-NEXT:    addi a0, a0, 16
; ZVFHMIN-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v24
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 5
; ZVFHMIN-NEXT:    add a0, sp, a0
; ZVFHMIN-NEXT:    addi a0, a0, 16
; ZVFHMIN-NEXT:    vl8r.v v0, (a0) # Unknown-size Folded Reload
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 4
; ZVFHMIN-NEXT:    add a0, sp, a0
; ZVFHMIN-NEXT:    addi a0, a0, 16
; ZVFHMIN-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; ZVFHMIN-NEXT:    vfmadd.vv v16, v8, v0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v0, v16
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    li a1, 24
; ZVFHMIN-NEXT:    mul a0, a0, a1
; ZVFHMIN-NEXT:    add a0, sp, a0
; ZVFHMIN-NEXT:    addi a0, a0, 16
; ZVFHMIN-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v12
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 5
; ZVFHMIN-NEXT:    add a0, sp, a0
; ZVFHMIN-NEXT:    addi a0, a0, 16
; ZVFHMIN-NEXT:    vs8r.v v16, (a0) # Unknown-size Folded Spill
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 3
; ZVFHMIN-NEXT:    add a0, sp, a0
; ZVFHMIN-NEXT:    addi a0, a0, 16
; ZVFHMIN-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    addi a0, sp, 16
; ZVFHMIN-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v20
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 5
; ZVFHMIN-NEXT:    add a0, sp, a0
; ZVFHMIN-NEXT:    addi a0, a0, 16
; ZVFHMIN-NEXT:    vl8r.v v16, (a0) # Unknown-size Folded Reload
; ZVFHMIN-NEXT:    vfmadd.vv v8, v24, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v4, v8
; ZVFHMIN-NEXT:    vmv8r.v v8, v0
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    li a1, 40
; ZVFHMIN-NEXT:    mul a0, a0, a1
; ZVFHMIN-NEXT:    add sp, sp, a0
; ZVFHMIN-NEXT:    addi sp, sp, 16
; ZVFHMIN-NEXT:    ret
  %vd = call <vscale x 32 x half> @llvm.fma.v32f16(<vscale x 32 x half> %vc, <vscale x 32 x half> %vb, <vscale x 32 x half> %va)
  ret <vscale x 32 x half> %vd
}

define <vscale x 32 x half> @vfmadd_vf_nxv32f16(<vscale x 32 x half> %va, <vscale x 32 x half> %vb, half %c) {
; ZVFH-LABEL: vfmadd_vf_nxv32f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; ZVFH-NEXT:    vfmacc.vf v8, fa0, v16
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfmadd_vf_nxv32f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    addi sp, sp, -16
; ZVFHMIN-NEXT:    .cfi_def_cfa_offset 16
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 4
; ZVFHMIN-NEXT:    sub sp, sp, a0
; ZVFHMIN-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; ZVFHMIN-NEXT:    addi a0, sp, 16
; ZVFHMIN-NEXT:    vs8r.v v8, (a0) # Unknown-size Folded Spill
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.v.f v24, fa5
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v0, v24
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v8
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 3
; ZVFHMIN-NEXT:    add a0, sp, a0
; ZVFHMIN-NEXT:    addi a0, a0, 16
; ZVFHMIN-NEXT:    vs8r.v v24, (a0) # Unknown-size Folded Spill
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v0
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v0, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 3
; ZVFHMIN-NEXT:    add a0, sp, a0
; ZVFHMIN-NEXT:    addi a0, a0, 16
; ZVFHMIN-NEXT:    vl8r.v v24, (a0) # Unknown-size Folded Reload
; ZVFHMIN-NEXT:    vfmadd.vv v0, v8, v24
; ZVFHMIN-NEXT:    vmv8r.v v24, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v16, v0
; ZVFHMIN-NEXT:    addi a0, sp, 16
; ZVFHMIN-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v0, v12
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v8, v20
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmadd.vv v8, v24, v0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v20, v8
; ZVFHMIN-NEXT:    vmv8r.v v8, v16
; ZVFHMIN-NEXT:    csrr a0, vlenb
; ZVFHMIN-NEXT:    slli a0, a0, 4
; ZVFHMIN-NEXT:    add sp, sp, a0
; ZVFHMIN-NEXT:    addi sp, sp, 16
; ZVFHMIN-NEXT:    ret
  %head = insertelement <vscale x 32 x half> poison, half %c, i32 0
  %splat = shufflevector <vscale x 32 x half> %head, <vscale x 32 x half> poison, <vscale x 32 x i32> zeroinitializer
  %vd = call <vscale x 32 x half> @llvm.fma.v32f16(<vscale x 32 x half> %vb, <vscale x 32 x half> %splat, <vscale x 32 x half> %va)
  ret <vscale x 32 x half> %vd
}

declare <vscale x 1 x float> @llvm.fma.v1f32(<vscale x 1 x float>, <vscale x 1 x float>, <vscale x 1 x float>)

define <vscale x 1 x float> @vfmadd_vv_nxv1f32(<vscale x 1 x float> %va, <vscale x 1 x float> %vb, <vscale x 1 x float> %vc) {
; CHECK-LABEL: vfmadd_vv_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfmadd.vv v8, v9, v10
; CHECK-NEXT:    ret
  %vd = call <vscale x 1 x float> @llvm.fma.v1f32(<vscale x 1 x float> %va, <vscale x 1 x float> %vb, <vscale x 1 x float> %vc)
  ret <vscale x 1 x float> %vd
}

define <vscale x 1 x float> @vfmadd_vf_nxv1f32(<vscale x 1 x float> %va, <vscale x 1 x float> %vb, float %c) {
; CHECK-LABEL: vfmadd_vf_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfmadd.vf v8, fa0, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x float> poison, float %c, i32 0
  %splat = shufflevector <vscale x 1 x float> %head, <vscale x 1 x float> poison, <vscale x 1 x i32> zeroinitializer
  %vd = call <vscale x 1 x float> @llvm.fma.v1f32(<vscale x 1 x float> %va, <vscale x 1 x float> %splat, <vscale x 1 x float> %vb)
  ret <vscale x 1 x float> %vd
}

declare <vscale x 2 x float> @llvm.fma.v2f32(<vscale x 2 x float>, <vscale x 2 x float>, <vscale x 2 x float>)

define <vscale x 2 x float> @vfmadd_vv_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x float> %vb, <vscale x 2 x float> %vc) {
; CHECK-LABEL: vfmadd_vv_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmadd.vv v8, v10, v9
; CHECK-NEXT:    ret
  %vd = call <vscale x 2 x float> @llvm.fma.v2f32(<vscale x 2 x float> %va, <vscale x 2 x float> %vc, <vscale x 2 x float> %vb)
  ret <vscale x 2 x float> %vd
}

define <vscale x 2 x float> @vfmadd_vf_nxv2f32(<vscale x 2 x float> %va, <vscale x 2 x float> %vb, float %c) {
; CHECK-LABEL: vfmadd_vf_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfmacc.vf v8, fa0, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x float> poison, float %c, i32 0
  %splat = shufflevector <vscale x 2 x float> %head, <vscale x 2 x float> poison, <vscale x 2 x i32> zeroinitializer
  %vd = call <vscale x 2 x float> @llvm.fma.v2f32(<vscale x 2 x float> %vb, <vscale x 2 x float> %splat, <vscale x 2 x float> %va)
  ret <vscale x 2 x float> %vd
}

declare <vscale x 4 x float> @llvm.fma.v4f32(<vscale x 4 x float>, <vscale x 4 x float>, <vscale x 4 x float>)

define <vscale x 4 x float> @vfmadd_vv_nxv4f32(<vscale x 4 x float> %va, <vscale x 4 x float> %vb, <vscale x 4 x float> %vc) {
; CHECK-LABEL: vfmadd_vv_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfmadd.vv v8, v10, v12
; CHECK-NEXT:    ret
  %vd = call <vscale x 4 x float> @llvm.fma.v4f32(<vscale x 4 x float> %vb, <vscale x 4 x float> %va, <vscale x 4 x float> %vc)
  ret <vscale x 4 x float> %vd
}

define <vscale x 4 x float> @vfmadd_vf_nxv4f32(<vscale x 4 x float> %va, <vscale x 4 x float> %vb, float %c) {
; CHECK-LABEL: vfmadd_vf_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfmadd.vf v8, fa0, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x float> poison, float %c, i32 0
  %splat = shufflevector <vscale x 4 x float> %head, <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer
  %vd = call <vscale x 4 x float> @llvm.fma.v4f32(<vscale x 4 x float> %va, <vscale x 4 x float> %splat, <vscale x 4 x float> %vb)
  ret <vscale x 4 x float> %vd
}

declare <vscale x 8 x float> @llvm.fma.v8f32(<vscale x 8 x float>, <vscale x 8 x float>, <vscale x 8 x float>)

define <vscale x 8 x float> @vfmadd_vv_nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x float> %vb, <vscale x 8 x float> %vc) {
; CHECK-LABEL: vfmadd_vv_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfmacc.vv v8, v16, v12
; CHECK-NEXT:    ret
  %vd = call <vscale x 8 x float> @llvm.fma.v8f32(<vscale x 8 x float> %vb, <vscale x 8 x float> %vc, <vscale x 8 x float> %va)
  ret <vscale x 8 x float> %vd
}

define <vscale x 8 x float> @vfmadd_vf_nxv8f32(<vscale x 8 x float> %va, <vscale x 8 x float> %vb, float %c) {
; CHECK-LABEL: vfmadd_vf_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfmacc.vf v8, fa0, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x float> poison, float %c, i32 0
  %splat = shufflevector <vscale x 8 x float> %head, <vscale x 8 x float> poison, <vscale x 8 x i32> zeroinitializer
  %vd = call <vscale x 8 x float> @llvm.fma.v8f32(<vscale x 8 x float> %vb, <vscale x 8 x float> %splat, <vscale x 8 x float> %va)
  ret <vscale x 8 x float> %vd
}

declare <vscale x 16 x float> @llvm.fma.v16f32(<vscale x 16 x float>, <vscale x 16 x float>, <vscale x 16 x float>)

define <vscale x 16 x float> @vfmadd_vv_nxv16f32(<vscale x 16 x float> %va, <vscale x 16 x float> %vb, <vscale x 16 x float> %vc) {
; CHECK-LABEL: vfmadd_vv_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl8re32.v v24, (a0)
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmadd.vv v8, v24, v16
; CHECK-NEXT:    ret
  %vd = call <vscale x 16 x float> @llvm.fma.v16f32(<vscale x 16 x float> %vc, <vscale x 16 x float> %va, <vscale x 16 x float> %vb)
  ret <vscale x 16 x float> %vd
}

define <vscale x 16 x float> @vfmadd_vf_nxv16f32(<vscale x 16 x float> %va, <vscale x 16 x float> %vb, float %c) {
; CHECK-LABEL: vfmadd_vf_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfmadd.vf v8, fa0, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 16 x float> poison, float %c, i32 0
  %splat = shufflevector <vscale x 16 x float> %head, <vscale x 16 x float> poison, <vscale x 16 x i32> zeroinitializer
  %vd = call <vscale x 16 x float> @llvm.fma.v16f32(<vscale x 16 x float> %va, <vscale x 16 x float> %splat, <vscale x 16 x float> %vb)
  ret <vscale x 16 x float> %vd
}

declare <vscale x 1 x double> @llvm.fma.v1f64(<vscale x 1 x double>, <vscale x 1 x double>, <vscale x 1 x double>)

define <vscale x 1 x double> @vfmadd_vv_nxv1f64(<vscale x 1 x double> %va, <vscale x 1 x double> %vb, <vscale x 1 x double> %vc) {
; CHECK-LABEL: vfmadd_vv_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfmadd.vv v8, v9, v10
; CHECK-NEXT:    ret
  %vd = call <vscale x 1 x double> @llvm.fma.v1f64(<vscale x 1 x double> %va, <vscale x 1 x double> %vb, <vscale x 1 x double> %vc)
  ret <vscale x 1 x double> %vd
}

define <vscale x 1 x double> @vfmadd_vf_nxv1f64(<vscale x 1 x double> %va, <vscale x 1 x double> %vb, double %c) {
; CHECK-LABEL: vfmadd_vf_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfmadd.vf v8, fa0, v9
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 1 x double> poison, double %c, i32 0
  %splat = shufflevector <vscale x 1 x double> %head, <vscale x 1 x double> poison, <vscale x 1 x i32> zeroinitializer
  %vd = call <vscale x 1 x double> @llvm.fma.v1f64(<vscale x 1 x double> %va, <vscale x 1 x double> %splat, <vscale x 1 x double> %vb)
  ret <vscale x 1 x double> %vd
}

declare <vscale x 2 x double> @llvm.fma.v2f64(<vscale x 2 x double>, <vscale x 2 x double>, <vscale x 2 x double>)

define <vscale x 2 x double> @vfmadd_vv_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x double> %vb, <vscale x 2 x double> %vc) {
; CHECK-LABEL: vfmadd_vv_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vfmadd.vv v8, v12, v10
; CHECK-NEXT:    ret
  %vd = call <vscale x 2 x double> @llvm.fma.v2f64(<vscale x 2 x double> %va, <vscale x 2 x double> %vc, <vscale x 2 x double> %vb)
  ret <vscale x 2 x double> %vd
}

define <vscale x 2 x double> @vfmadd_vf_nxv2f64(<vscale x 2 x double> %va, <vscale x 2 x double> %vb, double %c) {
; CHECK-LABEL: vfmadd_vf_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vfmacc.vf v8, fa0, v10
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 2 x double> poison, double %c, i32 0
  %splat = shufflevector <vscale x 2 x double> %head, <vscale x 2 x double> poison, <vscale x 2 x i32> zeroinitializer
  %vd = call <vscale x 2 x double> @llvm.fma.v2f64(<vscale x 2 x double> %vb, <vscale x 2 x double> %splat, <vscale x 2 x double> %va)
  ret <vscale x 2 x double> %vd
}

declare <vscale x 4 x double> @llvm.fma.v4f64(<vscale x 4 x double>, <vscale x 4 x double>, <vscale x 4 x double>)

define <vscale x 4 x double> @vfmadd_vv_nxv4f64(<vscale x 4 x double> %va, <vscale x 4 x double> %vb, <vscale x 4 x double> %vc) {
; CHECK-LABEL: vfmadd_vv_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vfmadd.vv v8, v12, v16
; CHECK-NEXT:    ret
  %vd = call <vscale x 4 x double> @llvm.fma.v4f64(<vscale x 4 x double> %vb, <vscale x 4 x double> %va, <vscale x 4 x double> %vc)
  ret <vscale x 4 x double> %vd
}

define <vscale x 4 x double> @vfmadd_vf_nxv4f64(<vscale x 4 x double> %va, <vscale x 4 x double> %vb, double %c) {
; CHECK-LABEL: vfmadd_vf_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vfmadd.vf v8, fa0, v12
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x double> poison, double %c, i32 0
  %splat = shufflevector <vscale x 4 x double> %head, <vscale x 4 x double> poison, <vscale x 4 x i32> zeroinitializer
  %vd = call <vscale x 4 x double> @llvm.fma.v4f64(<vscale x 4 x double> %va, <vscale x 4 x double> %splat, <vscale x 4 x double> %vb)
  ret <vscale x 4 x double> %vd
}

declare <vscale x 8 x double> @llvm.fma.v8f64(<vscale x 8 x double>, <vscale x 8 x double>, <vscale x 8 x double>)

define <vscale x 8 x double> @vfmadd_vv_nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x double> %vb, <vscale x 8 x double> %vc) {
; CHECK-LABEL: vfmadd_vv_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vl8re64.v v24, (a0)
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfmacc.vv v8, v16, v24
; CHECK-NEXT:    ret
  %vd = call <vscale x 8 x double> @llvm.fma.v8f64(<vscale x 8 x double> %vb, <vscale x 8 x double> %vc, <vscale x 8 x double> %va)
  ret <vscale x 8 x double> %vd
}

define <vscale x 8 x double> @vfmadd_vf_nxv8f64(<vscale x 8 x double> %va, <vscale x 8 x double> %vb, double %c) {
; CHECK-LABEL: vfmadd_vf_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfmacc.vf v8, fa0, v16
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 8 x double> poison, double %c, i32 0
  %splat = shufflevector <vscale x 8 x double> %head, <vscale x 8 x double> poison, <vscale x 8 x i32> zeroinitializer
  %vd = call <vscale x 8 x double> @llvm.fma.v8f64(<vscale x 8 x double> %vb, <vscale x 8 x double> %splat, <vscale x 8 x double> %va)
  ret <vscale x 8 x double> %vd
}
