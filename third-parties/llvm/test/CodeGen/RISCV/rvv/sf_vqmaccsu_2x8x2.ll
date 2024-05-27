; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: sed 's/iXLen/i32/g' %s | llc -mtriple=riscv32 -mattr=+v,+xsfvqmaccdod \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK
; RUN: sed 's/iXLen/i64/g' %s | llc -mtriple=riscv64 -mattr=+v,+xsfvqmaccdod \
; RUN:   -verify-machineinstrs | FileCheck %s --check-prefixes=CHECK

declare <vscale x 2 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv2i32.nxv8i8.nxv8i8(
  <vscale x 2 x i32>,
  <vscale x 8 x i8>,
  <vscale x 8 x i8>,
  iXLen, iXLen);

define <vscale x 2 x i32> @intrinsic_vqmaccsu_2x8x2_tu_i32m1(<vscale x 2 x i32> %0, <vscale x 8 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccsu_2x8x2_tu_i32m1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, tu, ma
; CHECK-NEXT:    sf.vqmaccsu.2x8x2 v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv2i32.nxv8i8.nxv8i8(
    <vscale x 2 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3, iXLen 2)

  ret <vscale x 2 x i32> %a
}

define <vscale x 2 x i32> @intrinsic_vqmaccsu_2x8x2_ta_i32m1(<vscale x 2 x i32> %0, <vscale x 8 x i8> %1, <vscale x 8 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccsu_2x8x2_ta_i32m1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m1, ta, ma
; CHECK-NEXT:    sf.vqmaccsu.2x8x2 v8, v9, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv2i32.nxv8i8.nxv8i8(
    <vscale x 2 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 8 x i8> %2,
    iXLen %3, iXLen 3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv4i32.nxv8i8.nxv16i8(
  <vscale x 4 x i32>,
  <vscale x 8 x i8>,
  <vscale x 16 x i8>,
  iXLen, iXLen);

define <vscale x 4 x i32> @intrinsic_vqmaccsu_2x8x2_tu_i32m2(<vscale x 4 x i32> %0, <vscale x 8 x i8> %1, <vscale x 16 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccsu_2x8x2_tu_i32m2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, tu, ma
; CHECK-NEXT:    sf.vqmaccsu.2x8x2 v8, v10, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv4i32.nxv8i8.nxv16i8(
    <vscale x 4 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 16 x i8> %2,
    iXLen %3, iXLen 2)

  ret <vscale x 4 x i32> %a
}

define <vscale x 4 x i32> @intrinsic_vqmaccsu_2x8x2_ta_i32m2(<vscale x 4 x i32> %0, <vscale x 8 x i8> %1, <vscale x 16 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccsu_2x8x2_ta_i32m2:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m2, ta, ma
; CHECK-NEXT:    sf.vqmaccsu.2x8x2 v8, v10, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv4i32.nxv8i8.nxv16i8(
    <vscale x 4 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 16 x i8> %2,
    iXLen %3, iXLen 3)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv8i32.nxv8i8.nxv32i8(
  <vscale x 8 x i32>,
  <vscale x 8 x i8>,
  <vscale x 32 x i8>,
  iXLen, iXLen);

define <vscale x 8 x i32> @intrinsic_vqmaccsu_2x8x2_tu_i32m4(<vscale x 8 x i32> %0, <vscale x 8 x i8> %1, <vscale x 32 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccsu_2x8x2_tu_i32m4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, tu, ma
; CHECK-NEXT:    sf.vqmaccsu.2x8x2 v8, v12, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv8i32.nxv8i8.nxv32i8(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 32 x i8> %2,
    iXLen %3, iXLen 2)

  ret <vscale x 8 x i32> %a
}

define <vscale x 8 x i32> @intrinsic_vqmaccsu_2x8x2_ta_i32m4(<vscale x 8 x i32> %0, <vscale x 8 x i8> %1, <vscale x 32 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccsu_2x8x2_ta_i32m4:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli zero, a0, e8, m4, ta, ma
; CHECK-NEXT:    sf.vqmaccsu.2x8x2 v8, v12, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv8i32.nxv8i8.nxv32i8(
    <vscale x 8 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 32 x i8> %2,
    iXLen %3, iXLen 3)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv16i32.nxv8i8.nxv64i8(
  <vscale x 16 x i32>,
  <vscale x 8 x i8>,
  <vscale x 64 x i8>,
  iXLen, iXLen);

define <vscale x 16 x i32> @intrinsic_vqmaccsu_2x8x2_tu_i32m8(<vscale x 16 x i32> %0, <vscale x 8 x i8> %1, <vscale x 64 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccsu_2x8x2_tu_i32m8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl8r.v v24, (a0)
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, tu, ma
; CHECK-NEXT:    sf.vqmaccsu.2x8x2 v8, v16, v24
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv16i32.nxv8i8.nxv64i8(
    <vscale x 16 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 64 x i8> %2,
    iXLen %3, iXLen 2)

  ret <vscale x 16 x i32> %a
}

define <vscale x 16 x i32> @intrinsic_vqmaccsu_2x8x2_ta_i32m8(<vscale x 16 x i32> %0, <vscale x 8 x i8> %1, <vscale x 64 x i8> %2, iXLen %3) nounwind {
; CHECK-LABEL: intrinsic_vqmaccsu_2x8x2_ta_i32m8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vl8r.v v24, (a0)
; CHECK-NEXT:    vsetvli zero, a1, e8, m8, ta, ma
; CHECK-NEXT:    sf.vqmaccsu.2x8x2 v8, v16, v24
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.sf.vqmaccsu.2x8x2.nxv16i32.nxv8i8.nxv64i8(
    <vscale x 16 x i32> %0,
    <vscale x 8 x i8> %1,
    <vscale x 64 x i8> %2,
    iXLen %3, iXLen 3)

  ret <vscale x 16 x i32> %a
}
