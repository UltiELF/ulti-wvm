; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfhmin,+zvfhmin,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfhmin,+zvfhmin,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN

declare half @llvm.vp.reduce.fadd.nxv1f16(half, <vscale x 1 x half>, <vscale x 1 x i1>, i32)

define half @vpreduce_fadd_nxv1f16(half %s, <vscale x 1 x half> %v, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vpreduce_fadd_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; ZVFH-NEXT:    vfmv.s.f v9, fa0
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; ZVFH-NEXT:    vfmv.f.s fa0, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v8, v9, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call reassoc half @llvm.vp.reduce.fadd.nxv1f16(half %s, <vscale x 1 x half> %v, <vscale x 1 x i1> %m, i32 %evl)
  ret half %r
}

define half @vpreduce_ord_fadd_nxv1f16(half %s, <vscale x 1 x half> %v, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vpreduce_ord_fadd_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; ZVFH-NEXT:    vfmv.s.f v9, fa0
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; ZVFH-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; ZVFH-NEXT:    vfmv.f.s fa0, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v8, v9, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call half @llvm.vp.reduce.fadd.nxv1f16(half %s, <vscale x 1 x half> %v, <vscale x 1 x i1> %m, i32 %evl)
  ret half %r
}

declare half @llvm.vp.reduce.fadd.nxv2f16(half, <vscale x 2 x half>, <vscale x 2 x i1>, i32)

define half @vpreduce_fadd_nxv2f16(half %s, <vscale x 2 x half> %v, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vpreduce_fadd_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; ZVFH-NEXT:    vfmv.s.f v9, fa0
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; ZVFH-NEXT:    vfmv.f.s fa0, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v8, v9, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call reassoc half @llvm.vp.reduce.fadd.nxv2f16(half %s, <vscale x 2 x half> %v, <vscale x 2 x i1> %m, i32 %evl)
  ret half %r
}

define half @vpreduce_ord_fadd_nxv2f16(half %s, <vscale x 2 x half> %v, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vpreduce_ord_fadd_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; ZVFH-NEXT:    vfmv.s.f v9, fa0
; ZVFH-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; ZVFH-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; ZVFH-NEXT:    vfmv.f.s fa0, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v8, v9, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call half @llvm.vp.reduce.fadd.nxv2f16(half %s, <vscale x 2 x half> %v, <vscale x 2 x i1> %m, i32 %evl)
  ret half %r
}

declare half @llvm.vp.reduce.fadd.nxv4f16(half, <vscale x 4 x half>, <vscale x 4 x i1>, i32)

define half @vpreduce_fadd_nxv4f16(half %s, <vscale x 4 x half> %v, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vpreduce_fadd_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; ZVFH-NEXT:    vfmv.s.f v9, fa0
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; ZVFH-NEXT:    vfmv.f.s fa0, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v8, v10, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call reassoc half @llvm.vp.reduce.fadd.nxv4f16(half %s, <vscale x 4 x half> %v, <vscale x 4 x i1> %m, i32 %evl)
  ret half %r
}

define half @vpreduce_ord_fadd_nxv4f16(half %s, <vscale x 4 x half> %v, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vpreduce_ord_fadd_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; ZVFH-NEXT:    vfmv.s.f v9, fa0
; ZVFH-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; ZVFH-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; ZVFH-NEXT:    vfmv.f.s fa0, v9
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a1, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v8, v10, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call half @llvm.vp.reduce.fadd.nxv4f16(half %s, <vscale x 4 x half> %v, <vscale x 4 x i1> %m, i32 %evl)
  ret half %r
}

declare half @llvm.vp.reduce.fadd.nxv64f16(half, <vscale x 64 x half>, <vscale x 64 x i1>, i32)

define half @vpreduce_fadd_nxv64f16(half %s, <vscale x 64 x half> %v, <vscale x 64 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vpreduce_fadd_nxv64f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    csrr a2, vlenb
; ZVFH-NEXT:    srli a1, a2, 1
; ZVFH-NEXT:    vsetvli a3, zero, e8, m1, ta, ma
; ZVFH-NEXT:    vslidedown.vx v24, v0, a1
; ZVFH-NEXT:    slli a2, a2, 2
; ZVFH-NEXT:    sub a1, a0, a2
; ZVFH-NEXT:    sltu a3, a0, a1
; ZVFH-NEXT:    addi a3, a3, -1
; ZVFH-NEXT:    and a1, a3, a1
; ZVFH-NEXT:    bltu a0, a2, .LBB6_2
; ZVFH-NEXT:  # %bb.1:
; ZVFH-NEXT:    mv a0, a2
; ZVFH-NEXT:  .LBB6_2:
; ZVFH-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfmv.s.f v25, fa0
; ZVFH-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; ZVFH-NEXT:    vfredusum.vs v25, v8, v25, v0.t
; ZVFH-NEXT:    vsetvli zero, a1, e16, m8, ta, ma
; ZVFH-NEXT:    vmv1r.v v0, v24
; ZVFH-NEXT:    vfredusum.vs v25, v16, v25, v0.t
; ZVFH-NEXT:    vfmv.f.s fa0, v25
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_fadd_nxv64f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    csrr a3, vlenb
; ZVFHMIN-NEXT:    srli a1, a3, 1
; ZVFHMIN-NEXT:    vsetvli a2, zero, e8, m1, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v1, v0, a1
; ZVFHMIN-NEXT:    slli a5, a3, 2
; ZVFHMIN-NEXT:    sub a1, a0, a5
; ZVFHMIN-NEXT:    sltu a2, a0, a1
; ZVFHMIN-NEXT:    addi a2, a2, -1
; ZVFHMIN-NEXT:    and a1, a2, a1
; ZVFHMIN-NEXT:    slli a4, a3, 1
; ZVFHMIN-NEXT:    sub a2, a1, a4
; ZVFHMIN-NEXT:    sltu a6, a1, a2
; ZVFHMIN-NEXT:    bltu a1, a4, .LBB6_2
; ZVFHMIN-NEXT:  # %bb.1:
; ZVFHMIN-NEXT:    mv a1, a4
; ZVFHMIN-NEXT:  .LBB6_2:
; ZVFHMIN-NEXT:    addi a6, a6, -1
; ZVFHMIN-NEXT:    bltu a0, a5, .LBB6_4
; ZVFHMIN-NEXT:  # %bb.3:
; ZVFHMIN-NEXT:    mv a0, a5
; ZVFHMIN-NEXT:  .LBB6_4:
; ZVFHMIN-NEXT:    and a2, a6, a2
; ZVFHMIN-NEXT:    sub a5, a0, a4
; ZVFHMIN-NEXT:    sltu a6, a0, a5
; ZVFHMIN-NEXT:    addi a6, a6, -1
; ZVFHMIN-NEXT:    and a5, a6, a5
; ZVFHMIN-NEXT:    srli a3, a3, 2
; ZVFHMIN-NEXT:    vsetvli a6, zero, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v2, v0, a3
; ZVFHMIN-NEXT:    bltu a0, a4, .LBB6_6
; ZVFHMIN-NEXT:  # %bb.5:
; ZVFHMIN-NEXT:    mv a0, a4
; ZVFHMIN-NEXT:  .LBB6_6:
; ZVFHMIN-NEXT:    vsetvli a4, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v8, v24, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa5, fa5
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa5
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    vsetvli zero, a5, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vmv1r.v v0, v2
; ZVFHMIN-NEXT:    vfredusum.vs v8, v24, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa5, fa5
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa5
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v16
; ZVFHMIN-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vmv1r.v v0, v1
; ZVFHMIN-NEXT:    vfredusum.vs v8, v24, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa5, fa5
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa5
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v0, v1, a3
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v20
; ZVFHMIN-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfredusum.vs v8, v24, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call reassoc half @llvm.vp.reduce.fadd.nxv64f16(half %s, <vscale x 64 x half> %v, <vscale x 64 x i1> %m, i32 %evl)
  ret half %r
}

define half @vpreduce_ord_fadd_nxv64f16(half %s, <vscale x 64 x half> %v, <vscale x 64 x i1> %m, i32 zeroext %evl) {
; ZVFH-LABEL: vpreduce_ord_fadd_nxv64f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    csrr a2, vlenb
; ZVFH-NEXT:    srli a1, a2, 1
; ZVFH-NEXT:    vsetvli a3, zero, e8, m1, ta, ma
; ZVFH-NEXT:    vslidedown.vx v24, v0, a1
; ZVFH-NEXT:    slli a2, a2, 2
; ZVFH-NEXT:    sub a1, a0, a2
; ZVFH-NEXT:    sltu a3, a0, a1
; ZVFH-NEXT:    addi a3, a3, -1
; ZVFH-NEXT:    and a1, a3, a1
; ZVFH-NEXT:    bltu a0, a2, .LBB7_2
; ZVFH-NEXT:  # %bb.1:
; ZVFH-NEXT:    mv a0, a2
; ZVFH-NEXT:  .LBB7_2:
; ZVFH-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfmv.s.f v25, fa0
; ZVFH-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; ZVFH-NEXT:    vfredosum.vs v25, v8, v25, v0.t
; ZVFH-NEXT:    vsetvli zero, a1, e16, m8, ta, ma
; ZVFH-NEXT:    vmv1r.v v0, v24
; ZVFH-NEXT:    vfredosum.vs v25, v16, v25, v0.t
; ZVFH-NEXT:    vfmv.f.s fa0, v25
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vpreduce_ord_fadd_nxv64f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    csrr a3, vlenb
; ZVFHMIN-NEXT:    srli a1, a3, 1
; ZVFHMIN-NEXT:    vsetvli a2, zero, e8, m1, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v1, v0, a1
; ZVFHMIN-NEXT:    slli a5, a3, 2
; ZVFHMIN-NEXT:    sub a1, a0, a5
; ZVFHMIN-NEXT:    sltu a2, a0, a1
; ZVFHMIN-NEXT:    addi a2, a2, -1
; ZVFHMIN-NEXT:    and a1, a2, a1
; ZVFHMIN-NEXT:    slli a4, a3, 1
; ZVFHMIN-NEXT:    sub a2, a1, a4
; ZVFHMIN-NEXT:    sltu a6, a1, a2
; ZVFHMIN-NEXT:    bltu a1, a4, .LBB7_2
; ZVFHMIN-NEXT:  # %bb.1:
; ZVFHMIN-NEXT:    mv a1, a4
; ZVFHMIN-NEXT:  .LBB7_2:
; ZVFHMIN-NEXT:    addi a6, a6, -1
; ZVFHMIN-NEXT:    bltu a0, a5, .LBB7_4
; ZVFHMIN-NEXT:  # %bb.3:
; ZVFHMIN-NEXT:    mv a0, a5
; ZVFHMIN-NEXT:  .LBB7_4:
; ZVFHMIN-NEXT:    and a2, a6, a2
; ZVFHMIN-NEXT:    sub a5, a0, a4
; ZVFHMIN-NEXT:    sltu a6, a0, a5
; ZVFHMIN-NEXT:    addi a6, a6, -1
; ZVFHMIN-NEXT:    and a5, a6, a5
; ZVFHMIN-NEXT:    srli a3, a3, 2
; ZVFHMIN-NEXT:    vsetvli a6, zero, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v2, v0, a3
; ZVFHMIN-NEXT:    bltu a0, a4, .LBB7_6
; ZVFHMIN-NEXT:  # %bb.5:
; ZVFHMIN-NEXT:    mv a0, a4
; ZVFHMIN-NEXT:  .LBB7_6:
; ZVFHMIN-NEXT:    vsetvli a4, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v8
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa0
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v8, v24, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa5, fa5
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa5
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v12
; ZVFHMIN-NEXT:    vsetvli zero, a5, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vmv1r.v v0, v2
; ZVFHMIN-NEXT:    vfredosum.vs v8, v24, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa5, fa5
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa5
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v16
; ZVFHMIN-NEXT:    vsetvli zero, a1, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vmv1r.v v0, v1
; ZVFHMIN-NEXT:    vfredosum.vs v8, v24, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa5, fa5
; ZVFHMIN-NEXT:    fcvt.s.h fa5, fa5
; ZVFHMIN-NEXT:    vsetivli zero, 1, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfmv.s.f v8, fa5
; ZVFHMIN-NEXT:    vsetvli a0, zero, e8, mf2, ta, ma
; ZVFHMIN-NEXT:    vslidedown.vx v0, v1, a3
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v24, v20
; ZVFHMIN-NEXT:    vsetvli zero, a2, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfredosum.vs v8, v24, v8, v0.t
; ZVFHMIN-NEXT:    vfmv.f.s fa5, v8
; ZVFHMIN-NEXT:    fcvt.h.s fa0, fa5
; ZVFHMIN-NEXT:    ret
  %r = call half @llvm.vp.reduce.fadd.nxv64f16(half %s, <vscale x 64 x half> %v, <vscale x 64 x i1> %m, i32 %evl)
  ret half %r
}

declare float @llvm.vp.reduce.fadd.nxv1f32(float, <vscale x 1 x float>, <vscale x 1 x i1>, i32)

define float @vpreduce_fadd_nxv1f32(float %s, <vscale x 1 x float> %v, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
  %r = call reassoc float @llvm.vp.reduce.fadd.nxv1f32(float %s, <vscale x 1 x float> %v, <vscale x 1 x i1> %m, i32 %evl)
  ret float %r
}

define float @vpreduce_ord_fadd_nxv1f32(float %s, <vscale x 1 x float> %v, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
  %r = call float @llvm.vp.reduce.fadd.nxv1f32(float %s, <vscale x 1 x float> %v, <vscale x 1 x i1> %m, i32 %evl)
  ret float %r
}

declare float @llvm.vp.reduce.fadd.nxv2f32(float, <vscale x 2 x float>, <vscale x 2 x i1>, i32)

define float @vpreduce_fadd_nxv2f32(float %s, <vscale x 2 x float> %v, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
  %r = call reassoc float @llvm.vp.reduce.fadd.nxv2f32(float %s, <vscale x 2 x float> %v, <vscale x 2 x i1> %m, i32 %evl)
  ret float %r
}

define float @vpreduce_ord_fadd_nxv2f32(float %s, <vscale x 2 x float> %v, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
  %r = call float @llvm.vp.reduce.fadd.nxv2f32(float %s, <vscale x 2 x float> %v, <vscale x 2 x i1> %m, i32 %evl)
  ret float %r
}

declare float @llvm.vp.reduce.fadd.nxv4f32(float, <vscale x 4 x float>, <vscale x 4 x i1>, i32)

define float @vpreduce_fadd_nxv4f32(float %s, <vscale x 4 x float> %v, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfredusum.vs v10, v8, v10, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v10
; CHECK-NEXT:    ret
  %r = call reassoc float @llvm.vp.reduce.fadd.nxv4f32(float %s, <vscale x 4 x float> %v, <vscale x 4 x i1> %m, i32 %evl)
  ret float %r
}

define float @vpreduce_ord_fadd_nxv4f32(float %s, <vscale x 4 x float> %v, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vfredosum.vs v10, v8, v10, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v10
; CHECK-NEXT:    ret
  %r = call float @llvm.vp.reduce.fadd.nxv4f32(float %s, <vscale x 4 x float> %v, <vscale x 4 x i1> %m, i32 %evl)
  ret float %r
}

declare double @llvm.vp.reduce.fadd.nxv1f64(double, <vscale x 1 x double>, <vscale x 1 x i1>, i32)

define double @vpreduce_fadd_nxv1f64(double %s, <vscale x 1 x double> %v, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfredusum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
  %r = call reassoc double @llvm.vp.reduce.fadd.nxv1f64(double %s, <vscale x 1 x double> %v, <vscale x 1 x i1> %m, i32 %evl)
  ret double %r
}

define double @vpreduce_ord_fadd_nxv1f64(double %s, <vscale x 1 x double> %v, <vscale x 1 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v9, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vfredosum.vs v9, v8, v9, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v9
; CHECK-NEXT:    ret
  %r = call double @llvm.vp.reduce.fadd.nxv1f64(double %s, <vscale x 1 x double> %v, <vscale x 1 x i1> %m, i32 %evl)
  ret double %r
}

declare double @llvm.vp.reduce.fadd.nxv2f64(double, <vscale x 2 x double>, <vscale x 2 x i1>, i32)

define double @vpreduce_fadd_nxv2f64(double %s, <vscale x 2 x double> %v, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfredusum.vs v10, v8, v10, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v10
; CHECK-NEXT:    ret
  %r = call reassoc double @llvm.vp.reduce.fadd.nxv2f64(double %s, <vscale x 2 x double> %v, <vscale x 2 x i1> %m, i32 %evl)
  ret double %r
}

define double @vpreduce_ord_fadd_nxv2f64(double %s, <vscale x 2 x double> %v, <vscale x 2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v10, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vfredosum.vs v10, v8, v10, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v10
; CHECK-NEXT:    ret
  %r = call double @llvm.vp.reduce.fadd.nxv2f64(double %s, <vscale x 2 x double> %v, <vscale x 2 x i1> %m, i32 %evl)
  ret double %r
}

declare double @llvm.vp.reduce.fadd.nxv3f64(double, <vscale x 3 x double>, <vscale x 3 x i1>, i32)

define double @vpreduce_fadd_nxv3f64(double %s, <vscale x 3 x double> %v, <vscale x 3 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_nxv3f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v12, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfredusum.vs v12, v8, v12, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v12
; CHECK-NEXT:    ret
  %r = call reassoc double @llvm.vp.reduce.fadd.nxv3f64(double %s, <vscale x 3 x double> %v, <vscale x 3 x i1> %m, i32 %evl)
  ret double %r
}

define double @vpreduce_ord_fadd_nxv3f64(double %s, <vscale x 3 x double> %v, <vscale x 3 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_nxv3f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v12, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfredosum.vs v12, v8, v12, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v12
; CHECK-NEXT:    ret
  %r = call double @llvm.vp.reduce.fadd.nxv3f64(double %s, <vscale x 3 x double> %v, <vscale x 3 x i1> %m, i32 %evl)
  ret double %r
}

declare double @llvm.vp.reduce.fadd.nxv4f64(double, <vscale x 4 x double>, <vscale x 4 x i1>, i32)

define double @vpreduce_fadd_nxv4f64(double %s, <vscale x 4 x double> %v, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_fadd_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v12, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfredusum.vs v12, v8, v12, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v12
; CHECK-NEXT:    ret
  %r = call reassoc double @llvm.vp.reduce.fadd.nxv4f64(double %s, <vscale x 4 x double> %v, <vscale x 4 x i1> %m, i32 %evl)
  ret double %r
}

define double @vpreduce_ord_fadd_nxv4f64(double %s, <vscale x 4 x double> %v, <vscale x 4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: vpreduce_ord_fadd_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vfmv.s.f v12, fa0
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vfredosum.vs v12, v8, v12, v0.t
; CHECK-NEXT:    vfmv.f.s fa0, v12
; CHECK-NEXT:    ret
  %r = call double @llvm.vp.reduce.fadd.nxv4f64(double %s, <vscale x 4 x double> %v, <vscale x 4 x i1> %m, i32 %evl)
  ret double %r
}
