; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+v \
; RUN:   -verify-machineinstrs | FileCheck %s
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+v \
; RUN:   -verify-machineinstrs | FileCheck %s

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv1i8(
  <vscale x 8 x i8>,
  <vscale x 1 x i8>,
  <vscale x 8 x i8>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_vs_nxv8i8_nxv1i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 1 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv8i8_nxv1i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv1i8(
    <vscale x 8 x i8> %0,
    <vscale x 1 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv1i8(
  <vscale x 8 x i8>,
  <vscale x 1 x i8>,
  <vscale x 8 x i8>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_mask_vs_nxv8i8_nxv1i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 1 x i8> %1, <vscale x 8 x i8> %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv8i8_nxv1i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf8, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv1i8(
    <vscale x 8 x i8> %0,
    <vscale x 1 x i8> %1,
    <vscale x 8 x i8> %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv2i8(
  <vscale x 8 x i8>,
  <vscale x 2 x i8>,
  <vscale x 8 x i8>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_vs_nxv8i8_nxv2i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 2 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv8i8_nxv2i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv2i8(
    <vscale x 8 x i8> %0,
    <vscale x 2 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv2i8(
  <vscale x 8 x i8>,
  <vscale x 2 x i8>,
  <vscale x 8 x i8>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_mask_vs_nxv8i8_nxv2i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 2 x i8> %1, <vscale x 8 x i8> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv8i8_nxv2i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv2i8(
    <vscale x 8 x i8> %0,
    <vscale x 2 x i8> %1,
    <vscale x 8 x i8> %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv4i8(
  <vscale x 8 x i8>,
  <vscale x 4 x i8>,
  <vscale x 8 x i8>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_vs_nxv8i8_nxv4i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 4 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv8i8_nxv4i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv4i8(
    <vscale x 8 x i8> %0,
    <vscale x 4 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv4i8(
  <vscale x 8 x i8>,
  <vscale x 4 x i8>,
  <vscale x 8 x i8>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_mask_vs_nxv8i8_nxv4i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 4 x i8> %1, <vscale x 8 x i8> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv8i8_nxv4i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, mf2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv4i8(
    <vscale x 8 x i8> %0,
    <vscale x 4 x i8> %1,
    <vscale x 8 x i8> %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_vs_nxv8i8_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv8i8_nxv8i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv8i8(
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_mask_vs_nxv8i8_nxv8i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 8 x i8> %1, <vscale x 8 x i8> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv8i8_nxv8i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv8i8(
    <vscale x 8 x i8> %0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i8> %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv16i8(
  <vscale x 8 x i8>,
  <vscale x 16 x i8>,
  <vscale x 8 x i8>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_vs_nxv8i8_nxv16i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 16 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv8i8_nxv16i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v10, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv16i8(
    <vscale x 8 x i8> %0,
    <vscale x 16 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv16i8(
  <vscale x 8 x i8>,
  <vscale x 16 x i8>,
  <vscale x 8 x i8>,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_mask_vs_nxv8i8_nxv16i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 16 x i8> %1, <vscale x 8 x i8> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv8i8_nxv16i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v10, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv16i8(
    <vscale x 8 x i8> %0,
    <vscale x 16 x i8> %1,
    <vscale x 8 x i8> %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv32i8(
  <vscale x 8 x i8>,
  <vscale x 32 x i8>,
  <vscale x 8 x i8>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_vs_nxv8i8_nxv32i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 32 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv8i8_nxv32i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v12, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.nxv8i8.nxv32i8(
    <vscale x 8 x i8> %0,
    <vscale x 32 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv32i8(
  <vscale x 8 x i8>,
  <vscale x 32 x i8>,
  <vscale x 8 x i8>,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 8 x i8> @intrinsic_vredmaxu_mask_vs_nxv8i8_nxv32i8_nxv8i8(<vscale x 8 x i8> %0, <vscale x 32 x i8> %1, <vscale x 8 x i8> %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv8i8_nxv32i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v12, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i8> @llvm.riscv.vredmaxu.mask.nxv8i8.nxv32i8(
    <vscale x 8 x i8> %0,
    <vscale x 32 x i8> %1,
    <vscale x 8 x i8> %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 8 x i8> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv1i16(
  <vscale x 4 x i16>,
  <vscale x 1 x i16>,
  <vscale x 4 x i16>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_vs_nxv4i16_nxv1i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 1 x i16> %1, <vscale x 4 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv4i16_nxv1i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv1i16(
    <vscale x 4 x i16> %0,
    <vscale x 1 x i16> %1,
    <vscale x 4 x i16> %2,
    iXLen %3)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv1i16(
  <vscale x 4 x i16>,
  <vscale x 1 x i16>,
  <vscale x 4 x i16>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_mask_vs_nxv4i16_nxv1i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 1 x i16> %1, <vscale x 4 x i16> %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv4i16_nxv1i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv1i16(
    <vscale x 4 x i16> %0,
    <vscale x 1 x i16> %1,
    <vscale x 4 x i16> %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv2i16(
  <vscale x 4 x i16>,
  <vscale x 2 x i16>,
  <vscale x 4 x i16>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_vs_nxv4i16_nxv2i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 2 x i16> %1, <vscale x 4 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv4i16_nxv2i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv2i16(
    <vscale x 4 x i16> %0,
    <vscale x 2 x i16> %1,
    <vscale x 4 x i16> %2,
    iXLen %3)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv2i16(
  <vscale x 4 x i16>,
  <vscale x 2 x i16>,
  <vscale x 4 x i16>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_mask_vs_nxv4i16_nxv2i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 2 x i16> %1, <vscale x 4 x i16> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv4i16_nxv2i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv2i16(
    <vscale x 4 x i16> %0,
    <vscale x 2 x i16> %1,
    <vscale x 4 x i16> %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>,
  <vscale x 4 x i16>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_vs_nxv4i16_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16> %1, <vscale x 4 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv4i16_nxv4i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16> %1,
    <vscale x 4 x i16> %2,
    iXLen %3)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv4i16(
  <vscale x 4 x i16>,
  <vscale x 4 x i16>,
  <vscale x 4 x i16>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_mask_vs_nxv4i16_nxv4i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 4 x i16> %1, <vscale x 4 x i16> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv4i16_nxv4i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m1, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv4i16(
    <vscale x 4 x i16> %0,
    <vscale x 4 x i16> %1,
    <vscale x 4 x i16> %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv8i16(
  <vscale x 4 x i16>,
  <vscale x 8 x i16>,
  <vscale x 4 x i16>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_vs_nxv4i16_nxv8i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 8 x i16> %1, <vscale x 4 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv4i16_nxv8i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v10, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv8i16(
    <vscale x 4 x i16> %0,
    <vscale x 8 x i16> %1,
    <vscale x 4 x i16> %2,
    iXLen %3)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv8i16(
  <vscale x 4 x i16>,
  <vscale x 8 x i16>,
  <vscale x 4 x i16>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_mask_vs_nxv4i16_nxv8i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 8 x i16> %1, <vscale x 4 x i16> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv4i16_nxv8i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v10, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv8i16(
    <vscale x 4 x i16> %0,
    <vscale x 8 x i16> %1,
    <vscale x 4 x i16> %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv16i16(
  <vscale x 4 x i16>,
  <vscale x 16 x i16>,
  <vscale x 4 x i16>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_vs_nxv4i16_nxv16i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 16 x i16> %1, <vscale x 4 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv4i16_nxv16i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v12, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv16i16(
    <vscale x 4 x i16> %0,
    <vscale x 16 x i16> %1,
    <vscale x 4 x i16> %2,
    iXLen %3)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv16i16(
  <vscale x 4 x i16>,
  <vscale x 16 x i16>,
  <vscale x 4 x i16>,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_mask_vs_nxv4i16_nxv16i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 16 x i16> %1, <vscale x 4 x i16> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv4i16_nxv16i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v12, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv16i16(
    <vscale x 4 x i16> %0,
    <vscale x 16 x i16> %1,
    <vscale x 4 x i16> %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv32i16(
  <vscale x 4 x i16>,
  <vscale x 32 x i16>,
  <vscale x 4 x i16>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_vs_nxv4i16_nxv32i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 32 x i16> %1, <vscale x 4 x i16> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv4i16_nxv32i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v16, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.nxv4i16.nxv32i16(
    <vscale x 4 x i16> %0,
    <vscale x 32 x i16> %1,
    <vscale x 4 x i16> %2,
    iXLen %3)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv32i16(
  <vscale x 4 x i16>,
  <vscale x 32 x i16>,
  <vscale x 4 x i16>,
  <vscale x 32 x i1>,
  iXLen);

define <vscale x 4 x i16> @intrinsic_vredmaxu_mask_vs_nxv4i16_nxv32i16_nxv4i16(<vscale x 4 x i16> %0, <vscale x 32 x i16> %1, <vscale x 4 x i16> %2, <vscale x 32 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv4i16_nxv32i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e16, m8, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v16, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vredmaxu.mask.nxv4i16.nxv32i16(
    <vscale x 4 x i16> %0,
    <vscale x 32 x i16> %1,
    <vscale x 4 x i16> %2,
    <vscale x 32 x i1> %3,
    iXLen %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vredmaxu.nxv2i32.nxv1i32(
  <vscale x 2 x i32>,
  <vscale x 1 x i32>,
  <vscale x 2 x i32>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vredmaxu_vs_nxv2i32_nxv1i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 1 x i32> %1, <vscale x 2 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv2i32_nxv1i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vredmaxu.nxv2i32.nxv1i32(
    <vscale x 2 x i32> %0,
    <vscale x 1 x i32> %1,
    <vscale x 2 x i32> %2,
    iXLen %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vredmaxu.mask.nxv2i32.nxv1i32(
  <vscale x 2 x i32>,
  <vscale x 1 x i32>,
  <vscale x 2 x i32>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vredmaxu_mask_vs_nxv2i32_nxv1i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 1 x i32> %1, <vscale x 2 x i32> %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv2i32_nxv1i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, mf2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vredmaxu.mask.nxv2i32.nxv1i32(
    <vscale x 2 x i32> %0,
    <vscale x 1 x i32> %1,
    <vscale x 2 x i32> %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vredmaxu.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vredmaxu_vs_nxv2i32_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32> %1, <vscale x 2 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv2i32_nxv2i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vredmaxu.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i32> %2,
    iXLen %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vredmaxu.mask.nxv2i32.nxv2i32(
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vredmaxu_mask_vs_nxv2i32_nxv2i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 2 x i32> %1, <vscale x 2 x i32> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv2i32_nxv2i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vredmaxu.mask.nxv2i32.nxv2i32(
    <vscale x 2 x i32> %0,
    <vscale x 2 x i32> %1,
    <vscale x 2 x i32> %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vredmaxu.nxv2i32.nxv4i32(
  <vscale x 2 x i32>,
  <vscale x 4 x i32>,
  <vscale x 2 x i32>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vredmaxu_vs_nxv2i32_nxv4i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 4 x i32> %1, <vscale x 2 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv2i32_nxv4i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v10, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vredmaxu.nxv2i32.nxv4i32(
    <vscale x 2 x i32> %0,
    <vscale x 4 x i32> %1,
    <vscale x 2 x i32> %2,
    iXLen %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vredmaxu.mask.nxv2i32.nxv4i32(
  <vscale x 2 x i32>,
  <vscale x 4 x i32>,
  <vscale x 2 x i32>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vredmaxu_mask_vs_nxv2i32_nxv4i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 4 x i32> %1, <vscale x 2 x i32> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv2i32_nxv4i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v10, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vredmaxu.mask.nxv2i32.nxv4i32(
    <vscale x 2 x i32> %0,
    <vscale x 4 x i32> %1,
    <vscale x 2 x i32> %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vredmaxu.nxv2i32.nxv8i32(
  <vscale x 2 x i32>,
  <vscale x 8 x i32>,
  <vscale x 2 x i32>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vredmaxu_vs_nxv2i32_nxv8i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 8 x i32> %1, <vscale x 2 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv2i32_nxv8i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v12, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vredmaxu.nxv2i32.nxv8i32(
    <vscale x 2 x i32> %0,
    <vscale x 8 x i32> %1,
    <vscale x 2 x i32> %2,
    iXLen %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vredmaxu.mask.nxv2i32.nxv8i32(
  <vscale x 2 x i32>,
  <vscale x 8 x i32>,
  <vscale x 2 x i32>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vredmaxu_mask_vs_nxv2i32_nxv8i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 8 x i32> %1, <vscale x 2 x i32> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv2i32_nxv8i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v12, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vredmaxu.mask.nxv2i32.nxv8i32(
    <vscale x 2 x i32> %0,
    <vscale x 8 x i32> %1,
    <vscale x 2 x i32> %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vredmaxu.nxv2i32.nxv16i32(
  <vscale x 2 x i32>,
  <vscale x 16 x i32>,
  <vscale x 2 x i32>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vredmaxu_vs_nxv2i32_nxv16i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 16 x i32> %1, <vscale x 2 x i32> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv2i32_nxv16i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v16, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vredmaxu.nxv2i32.nxv16i32(
    <vscale x 2 x i32> %0,
    <vscale x 16 x i32> %1,
    <vscale x 2 x i32> %2,
    iXLen %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vredmaxu.mask.nxv2i32.nxv16i32(
  <vscale x 2 x i32>,
  <vscale x 16 x i32>,
  <vscale x 2 x i32>,
  <vscale x 16 x i1>,
  iXLen);

define <vscale x 2 x i32> @intrinsic_vredmaxu_mask_vs_nxv2i32_nxv16i32_nxv2i32(<vscale x 2 x i32> %0, <vscale x 16 x i32> %1, <vscale x 2 x i32> %2, <vscale x 16 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv2i32_nxv16i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e32, m8, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v16, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vredmaxu.mask.nxv2i32.nxv16i32(
    <vscale x 2 x i32> %0,
    <vscale x 16 x i32> %1,
    <vscale x 2 x i32> %2,
    <vscale x 16 x i1> %3,
    iXLen %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vredmaxu.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vredmaxu_vs_nxv1i64_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64> %1, <vscale x 1 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv1i64_nxv1i64_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vredmaxu.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64> %1,
    <vscale x 1 x i64> %2,
    iXLen %3)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vredmaxu.mask.nxv1i64.nxv1i64(
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  <vscale x 1 x i64>,
  <vscale x 1 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vredmaxu_mask_vs_nxv1i64_nxv1i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 1 x i64> %1, <vscale x 1 x i64> %2, <vscale x 1 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv1i64_nxv1i64_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m1, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v9, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vredmaxu.mask.nxv1i64.nxv1i64(
    <vscale x 1 x i64> %0,
    <vscale x 1 x i64> %1,
    <vscale x 1 x i64> %2,
    <vscale x 1 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vredmaxu.nxv1i64.nxv2i64(
  <vscale x 1 x i64>,
  <vscale x 2 x i64>,
  <vscale x 1 x i64>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vredmaxu_vs_nxv1i64_nxv2i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 2 x i64> %1, <vscale x 1 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv1i64_nxv2i64_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v10, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vredmaxu.nxv1i64.nxv2i64(
    <vscale x 1 x i64> %0,
    <vscale x 2 x i64> %1,
    <vscale x 1 x i64> %2,
    iXLen %3)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vredmaxu.mask.nxv1i64.nxv2i64(
  <vscale x 1 x i64>,
  <vscale x 2 x i64>,
  <vscale x 1 x i64>,
  <vscale x 2 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vredmaxu_mask_vs_nxv1i64_nxv2i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 2 x i64> %1, <vscale x 1 x i64> %2, <vscale x 2 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv1i64_nxv2i64_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m2, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v10, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vredmaxu.mask.nxv1i64.nxv2i64(
    <vscale x 1 x i64> %0,
    <vscale x 2 x i64> %1,
    <vscale x 1 x i64> %2,
    <vscale x 2 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vredmaxu.nxv1i64.nxv4i64(
  <vscale x 1 x i64>,
  <vscale x 4 x i64>,
  <vscale x 1 x i64>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vredmaxu_vs_nxv1i64_nxv4i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 4 x i64> %1, <vscale x 1 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv1i64_nxv4i64_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v12, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vredmaxu.nxv1i64.nxv4i64(
    <vscale x 1 x i64> %0,
    <vscale x 4 x i64> %1,
    <vscale x 1 x i64> %2,
    iXLen %3)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vredmaxu.mask.nxv1i64.nxv4i64(
  <vscale x 1 x i64>,
  <vscale x 4 x i64>,
  <vscale x 1 x i64>,
  <vscale x 4 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vredmaxu_mask_vs_nxv1i64_nxv4i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 4 x i64> %1, <vscale x 1 x i64> %2, <vscale x 4 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv1i64_nxv4i64_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m4, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v12, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vredmaxu.mask.nxv1i64.nxv4i64(
    <vscale x 1 x i64> %0,
    <vscale x 4 x i64> %1,
    <vscale x 1 x i64> %2,
    <vscale x 4 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vredmaxu.nxv1i64.nxv8i64(
  <vscale x 1 x i64>,
  <vscale x 8 x i64>,
  <vscale x 1 x i64>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vredmaxu_vs_nxv1i64_nxv8i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 8 x i64> %1, <vscale x 1 x i64> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_vs_nxv1i64_nxv8i64_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v16, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vredmaxu.nxv1i64.nxv8i64(
    <vscale x 1 x i64> %0,
    <vscale x 8 x i64> %1,
    <vscale x 1 x i64> %2,
    iXLen %3)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vredmaxu.mask.nxv1i64.nxv8i64(
  <vscale x 1 x i64>,
  <vscale x 8 x i64>,
  <vscale x 1 x i64>,
  <vscale x 8 x i1>,
  iXLen);

define <vscale x 1 x i64> @intrinsic_vredmaxu_mask_vs_nxv1i64_nxv8i64_nxv1i64(<vscale x 1 x i64> %0, <vscale x 8 x i64> %1, <vscale x 1 x i64> %2, <vscale x 8 x i1> %3, iXLen %4) nounwind {
; CHECK-LABEL: intrinsic_vredmaxu_mask_vs_nxv1i64_nxv8i64_nxv1i64:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e64, m8, ta, ma
; CHECK-NEXT:    vredmaxu.vs v8, v16, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vredmaxu.mask.nxv1i64.nxv8i64(
    <vscale x 1 x i64> %0,
    <vscale x 8 x i64> %1,
    <vscale x 1 x i64> %2,
    <vscale x 8 x i1> %3,
    iXLen %4)

  ret <vscale x 1 x i64> %a
}
