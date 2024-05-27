; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v,+m -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v,+m -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfhmin,+v,+m -verify-machineinstrs < %s | FileCheck %s
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfhmin,+v,+m -verify-machineinstrs < %s | FileCheck %s

declare <vscale x 2 x half> @llvm.vp.fptrunc.nxv2f16.nxv2f32(<vscale x 2 x float>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vfptrunc_nxv2f16_nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vfptrunc_nxv2f16_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.f.f.w v9, v8, v0.t
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.fptrunc.nxv2f16.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x i1> %m, i32 %vl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vfptrunc_nxv2f16_nxv2f32_unmasked(<vscale x 2 x float> %a, i32 zeroext %vl) {
; CHECK-LABEL: vfptrunc_nxv2f16_nxv2f32_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.f.f.w v9, v8
; CHECK-NEXT:    vmv1r.v v8, v9
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.fptrunc.nxv2f16.nxv2f32(<vscale x 2 x float> %a, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %vl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x half> @llvm.vp.fptrunc.nxv2f16.nxv2f64(<vscale x 2 x double>, <vscale x 2 x i1>, i32)

define <vscale x 2 x half> @vfptrunc_nxv2f16_nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vfptrunc_nxv2f16_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.rod.f.f.w v10, v8, v0.t
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.f.f.w v8, v10, v0.t
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.fptrunc.nxv2f16.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x i1> %m, i32 %vl)
  ret <vscale x 2 x half> %v
}

define <vscale x 2 x half> @vfptrunc_nxv2f16_nxv2f64_unmasked(<vscale x 2 x double> %a, i32 zeroext %vl) {
; CHECK-LABEL: vfptrunc_nxv2f16_nxv2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.rod.f.f.w v10, v8
; CHECK-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; CHECK-NEXT:    vfncvt.f.f.w v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x half> @llvm.vp.fptrunc.nxv2f16.nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %vl)
  ret <vscale x 2 x half> %v
}

declare <vscale x 2 x float> @llvm.vp.fptrunc.nxv2f64.nxv2f32(<vscale x 2 x double>, <vscale x 2 x i1>, i32)

define <vscale x 2 x float> @vfptrunc_nxv2f32_nxv2f64(<vscale x 2 x double> %a, <vscale x 2 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vfptrunc_nxv2f32_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.f.w v10, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.fptrunc.nxv2f64.nxv2f32(<vscale x 2 x double> %a, <vscale x 2 x i1> %m, i32 %vl)
  ret <vscale x 2 x float> %v
}

define <vscale x 2 x float> @vfptrunc_nxv2f32_nxv2f64_unmasked(<vscale x 2 x double> %a, i32 zeroext %vl) {
; CHECK-LABEL: vfptrunc_nxv2f32_nxv2f64_unmasked:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m1, ta, ma
; CHECK-NEXT:    vfncvt.f.f.w v10, v8
; CHECK-NEXT:    vmv.v.v v8, v10
; CHECK-NEXT:    ret
  %v = call <vscale x 2 x float> @llvm.vp.fptrunc.nxv2f64.nxv2f32(<vscale x 2 x double> %a, <vscale x 2 x i1> shufflevector (<vscale x 2 x i1> insertelement (<vscale x 2 x i1> undef, i1 true, i32 0), <vscale x 2 x i1> undef, <vscale x 2 x i32> zeroinitializer), i32 %vl)
  ret <vscale x 2 x float> %v
}

declare <vscale x 7 x float> @llvm.vp.fptrunc.nxv7f64.nxv7f32(<vscale x 7 x double>, <vscale x 7 x i1>, i32)

define <vscale x 7 x float> @vfptrunc_nxv7f32_nxv7f64(<vscale x 7 x double> %a, <vscale x 7 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vfptrunc_nxv7f32_nxv7f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vfncvt.f.f.w v16, v8, v0.t
; CHECK-NEXT:    vmv.v.v v8, v16
; CHECK-NEXT:    ret
  %v = call <vscale x 7 x float> @llvm.vp.fptrunc.nxv7f64.nxv7f32(<vscale x 7 x double> %a, <vscale x 7 x i1> %m, i32 %vl)
  ret <vscale x 7 x float> %v
}

declare <vscale x 16 x float> @llvm.vp.fptrunc.nxv16f64.nxv16f32(<vscale x 16 x double>, <vscale x 16 x i1>, i32)

define <vscale x 16 x float> @vfptrunc_nxv16f32_nxv16f64(<vscale x 16 x double> %a, <vscale x 16 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vfptrunc_nxv16f32_nxv16f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x08, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 8 * vlenb
; CHECK-NEXT:    vmv1r.v v1, v0
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v16, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a2, a1, 3
; CHECK-NEXT:    vsetvli a3, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v0, v0, a2
; CHECK-NEXT:    sub a2, a0, a1
; CHECK-NEXT:    sltu a3, a0, a2
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a2, a3, a2
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, ta, ma
; CHECK-NEXT:    addi a2, sp, 16
; CHECK-NEXT:    vl8r.v v24, (a2) # Unknown-size Folded Reload
; CHECK-NEXT:    vfncvt.f.f.w v20, v24, v0.t
; CHECK-NEXT:    bltu a0, a1, .LBB7_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a1
; CHECK-NEXT:  .LBB7_2:
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v1
; CHECK-NEXT:    vfncvt.f.f.w v16, v8, v0.t
; CHECK-NEXT:    vmv8r.v v8, v16
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <vscale x 16 x float> @llvm.vp.fptrunc.nxv16f64.nxv16f32(<vscale x 16 x double> %a, <vscale x 16 x i1> %m, i32 %vl)
  ret <vscale x 16 x float> %v
}

declare <vscale x 32 x float> @llvm.vp.fptrunc.nxv32f64.nxv32f32(<vscale x 32 x double>, <vscale x 32 x i1>, i32)

define <vscale x 32 x float> @vfptrunc_nxv32f32_nxv32f64(<vscale x 32 x double> %a, <vscale x 32 x i1> %m, i32 zeroext %vl) {
; CHECK-LABEL: vfptrunc_nxv32f32_nxv32f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -16
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    sub sp, sp, a1
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0d, 0x72, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0xa2, 0x38, 0x00, 0x1e, 0x22 # sp + 16 + 16 * vlenb
; CHECK-NEXT:    vmv1r.v v1, v0
; CHECK-NEXT:    addi a1, sp, 16
; CHECK-NEXT:    vs8r.v v16, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, sp, a1
; CHECK-NEXT:    addi a1, a1, 16
; CHECK-NEXT:    vs8r.v v8, (a1) # Unknown-size Folded Spill
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    srli a3, a1, 3
; CHECK-NEXT:    srli a4, a1, 2
; CHECK-NEXT:    vsetvli a5, zero, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v16, v0, a4
; CHECK-NEXT:    slli a4, a1, 3
; CHECK-NEXT:    add a4, a0, a4
; CHECK-NEXT:    vl8re64.v v8, (a4)
; CHECK-NEXT:    slli a4, a1, 1
; CHECK-NEXT:    sub a5, a2, a4
; CHECK-NEXT:    sltu a6, a2, a5
; CHECK-NEXT:    addi a6, a6, -1
; CHECK-NEXT:    and a5, a6, a5
; CHECK-NEXT:    sub a6, a5, a1
; CHECK-NEXT:    sltu a7, a5, a6
; CHECK-NEXT:    addi a7, a7, -1
; CHECK-NEXT:    and a6, a7, a6
; CHECK-NEXT:    vsetvli a7, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vl8re64.v v24, (a0)
; CHECK-NEXT:    vslidedown.vx v0, v16, a3
; CHECK-NEXT:    vsetvli zero, a6, e32, m4, ta, ma
; CHECK-NEXT:    vfncvt.f.f.w v20, v8, v0.t
; CHECK-NEXT:    bltu a5, a1, .LBB8_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a5, a1
; CHECK-NEXT:  .LBB8_2:
; CHECK-NEXT:    vsetvli a0, zero, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v2, v1, a3
; CHECK-NEXT:    vsetvli zero, a5, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v16
; CHECK-NEXT:    vfncvt.f.f.w v16, v24, v0.t
; CHECK-NEXT:    bltu a2, a4, .LBB8_4
; CHECK-NEXT:  # %bb.3:
; CHECK-NEXT:    mv a2, a4
; CHECK-NEXT:  .LBB8_4:
; CHECK-NEXT:    sub a0, a2, a1
; CHECK-NEXT:    sltu a3, a2, a0
; CHECK-NEXT:    addi a3, a3, -1
; CHECK-NEXT:    and a0, a3, a0
; CHECK-NEXT:    vsetvli zero, a0, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v2
; CHECK-NEXT:    addi a0, sp, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vfncvt.f.f.w v28, v8, v0.t
; CHECK-NEXT:    bltu a2, a1, .LBB8_6
; CHECK-NEXT:  # %bb.5:
; CHECK-NEXT:    mv a2, a1
; CHECK-NEXT:  .LBB8_6:
; CHECK-NEXT:    vsetvli zero, a2, e32, m4, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v1
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 3
; CHECK-NEXT:    add a0, sp, a0
; CHECK-NEXT:    addi a0, a0, 16
; CHECK-NEXT:    vl8r.v v8, (a0) # Unknown-size Folded Reload
; CHECK-NEXT:    vfncvt.f.f.w v24, v8, v0.t
; CHECK-NEXT:    vmv8r.v v8, v24
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    add sp, sp, a0
; CHECK-NEXT:    addi sp, sp, 16
; CHECK-NEXT:    ret
  %v = call <vscale x 32 x float> @llvm.vp.fptrunc.nxv32f64.nxv32f32(<vscale x 32 x double> %a, <vscale x 32 x i1> %m, i32 %vl)
  ret <vscale x 32 x float> %v
}
