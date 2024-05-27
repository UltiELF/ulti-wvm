; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfh,+zvfh,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFH
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfhmin,+zvfhmin,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN
; RUN: llc -mtriple=riscv64 -mattr=+d,+zfhmin,+zvfhmin,+v -target-abi=lp64d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,ZVFHMIN

declare <vscale x 1 x half> @llvm.experimental.constrained.sqrt.nxv1f16(<vscale x 1 x half>, metadata, metadata)

define <vscale x 1 x half> @vfsqrt_nxv1f16(<vscale x 1 x half> %v) strictfp {
; ZVFH-LABEL: vfsqrt_nxv1f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_nxv1f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, mf2, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v9, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %r = call <vscale x 1 x half> @llvm.experimental.constrained.sqrt.nxv1f16(<vscale x 1 x half> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 1 x half> %r
}

declare <vscale x 2 x half> @llvm.experimental.constrained.sqrt.nxv2f16(<vscale x 2 x half>, metadata, metadata)

define <vscale x 2 x half> @vfsqrt_nxv2f16(<vscale x 2 x half> %v) strictfp {
; ZVFH-LABEL: vfsqrt_nxv2f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_nxv2f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v9, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m1, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v9, v9
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, mf2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v9
; ZVFHMIN-NEXT:    ret
  %r = call <vscale x 2 x half> @llvm.experimental.constrained.sqrt.nxv2f16(<vscale x 2 x half> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 2 x half> %r
}

declare <vscale x 4 x half> @llvm.experimental.constrained.sqrt.nxv4f16(<vscale x 4 x half>, metadata, metadata)

define <vscale x 4 x half> @vfsqrt_nxv4f16(<vscale x 4 x half> %v) strictfp {
; ZVFH-LABEL: vfsqrt_nxv4f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_nxv4f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v10, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m2, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v10, v10
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m1, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v10
; ZVFHMIN-NEXT:    ret
  %r = call <vscale x 4 x half> @llvm.experimental.constrained.sqrt.nxv4f16(<vscale x 4 x half> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 4 x half> %r
}

declare <vscale x 8 x half> @llvm.experimental.constrained.sqrt.nxv8f16(<vscale x 8 x half>, metadata, metadata)

define <vscale x 8 x half> @vfsqrt_nxv8f16(<vscale x 8 x half> %v) strictfp {
; ZVFH-LABEL: vfsqrt_nxv8f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_nxv8f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v12, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m4, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v12, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m2, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v12
; ZVFHMIN-NEXT:    ret
  %r = call <vscale x 8 x half> @llvm.experimental.constrained.sqrt.nxv8f16(<vscale x 8 x half> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 8 x half> %r
}

declare <vscale x 16 x half> @llvm.experimental.constrained.sqrt.nxv16f16(<vscale x 16 x half>, metadata, metadata)

define <vscale x 16 x half> @vfsqrt_nxv16f16(<vscale x 16 x half> %v) strictfp {
; ZVFH-LABEL: vfsqrt_nxv16f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_nxv16f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v16, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    ret
  %r = call <vscale x 16 x half> @llvm.experimental.constrained.sqrt.nxv16f16(<vscale x 16 x half> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 16 x half> %r
}

declare <vscale x 32 x half> @llvm.experimental.constrained.sqrt.nxv32f16(<vscale x 32 x half>, metadata, metadata)

define <vscale x 32 x half> @vfsqrt_nxv32f16(<vscale x 32 x half> %v) strictfp {
; ZVFH-LABEL: vfsqrt_nxv32f16:
; ZVFH:       # %bb.0:
; ZVFH-NEXT:    vsetvli a0, zero, e16, m8, ta, ma
; ZVFH-NEXT:    vfsqrt.v v8, v8
; ZVFH-NEXT:    ret
;
; ZVFHMIN-LABEL: vfsqrt_nxv32f16:
; ZVFHMIN:       # %bb.0:
; ZVFHMIN-NEXT:    vsetvli a0, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v8
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v16, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v8, v16
; ZVFHMIN-NEXT:    vfwcvt.f.f.v v16, v12
; ZVFHMIN-NEXT:    vsetvli zero, zero, e32, m8, ta, ma
; ZVFHMIN-NEXT:    vfsqrt.v v16, v16
; ZVFHMIN-NEXT:    vsetvli zero, zero, e16, m4, ta, ma
; ZVFHMIN-NEXT:    vfncvt.f.f.w v12, v16
; ZVFHMIN-NEXT:    ret
  %r = call <vscale x 32 x half> @llvm.experimental.constrained.sqrt.nxv32f16(<vscale x 32 x half> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 32 x half> %r
}

declare <vscale x 1 x float> @llvm.experimental.constrained.sqrt.nxv1f32(<vscale x 1 x float>, metadata, metadata)

define <vscale x 1 x float> @vfsqrt_nxv1f32(<vscale x 1 x float> %v) strictfp {
; CHECK-LABEL: vfsqrt_nxv1f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, mf2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %r = call <vscale x 1 x float> @llvm.experimental.constrained.sqrt.nxv1f32(<vscale x 1 x float> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 1 x float> %r
}

declare <vscale x 2 x float> @llvm.experimental.constrained.sqrt.nxv2f32(<vscale x 2 x float>, metadata, metadata)

define <vscale x 2 x float> @vfsqrt_nxv2f32(<vscale x 2 x float> %v) strictfp {
; CHECK-LABEL: vfsqrt_nxv2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %r = call <vscale x 2 x float> @llvm.experimental.constrained.sqrt.nxv2f32(<vscale x 2 x float> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 2 x float> %r
}

declare <vscale x 4 x float> @llvm.experimental.constrained.sqrt.nxv4f32(<vscale x 4 x float>, metadata, metadata)

define <vscale x 4 x float> @vfsqrt_nxv4f32(<vscale x 4 x float> %v) strictfp {
; CHECK-LABEL: vfsqrt_nxv4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %r = call <vscale x 4 x float> @llvm.experimental.constrained.sqrt.nxv4f32(<vscale x 4 x float> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 4 x float> %r
}

declare <vscale x 8 x float> @llvm.experimental.constrained.sqrt.nxv8f32(<vscale x 8 x float>, metadata, metadata)

define <vscale x 8 x float> @vfsqrt_nxv8f32(<vscale x 8 x float> %v) strictfp {
; CHECK-LABEL: vfsqrt_nxv8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %r = call <vscale x 8 x float> @llvm.experimental.constrained.sqrt.nxv8f32(<vscale x 8 x float> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 8 x float> %r
}

declare <vscale x 16 x float> @llvm.experimental.constrained.sqrt.nxv16f32(<vscale x 16 x float>, metadata, metadata)

define <vscale x 16 x float> @vfsqrt_nxv16f32(<vscale x 16 x float> %v) strictfp {
; CHECK-LABEL: vfsqrt_nxv16f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e32, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %r = call <vscale x 16 x float> @llvm.experimental.constrained.sqrt.nxv16f32(<vscale x 16 x float> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 16 x float> %r
}

declare <vscale x 1 x double> @llvm.experimental.constrained.sqrt.nxv1f64(<vscale x 1 x double>, metadata, metadata)

define <vscale x 1 x double> @vfsqrt_nxv1f64(<vscale x 1 x double> %v) strictfp {
; CHECK-LABEL: vfsqrt_nxv1f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m1, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %r = call <vscale x 1 x double> @llvm.experimental.constrained.sqrt.nxv1f64(<vscale x 1 x double> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 1 x double> %r
}

declare <vscale x 2 x double> @llvm.experimental.constrained.sqrt.nxv2f64(<vscale x 2 x double>, metadata, metadata)

define <vscale x 2 x double> @vfsqrt_nxv2f64(<vscale x 2 x double> %v) strictfp {
; CHECK-LABEL: vfsqrt_nxv2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m2, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %r = call <vscale x 2 x double> @llvm.experimental.constrained.sqrt.nxv2f64(<vscale x 2 x double> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 2 x double> %r
}

declare <vscale x 4 x double> @llvm.experimental.constrained.sqrt.nxv4f64(<vscale x 4 x double>, metadata, metadata)

define <vscale x 4 x double> @vfsqrt_nxv4f64(<vscale x 4 x double> %v) strictfp {
; CHECK-LABEL: vfsqrt_nxv4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m4, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %r = call <vscale x 4 x double> @llvm.experimental.constrained.sqrt.nxv4f64(<vscale x 4 x double> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 4 x double> %r
}

declare <vscale x 8 x double> @llvm.experimental.constrained.sqrt.nxv8f64(<vscale x 8 x double>, metadata, metadata)

define <vscale x 8 x double> @vfsqrt_nxv8f64(<vscale x 8 x double> %v) strictfp {
; CHECK-LABEL: vfsqrt_nxv8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e64, m8, ta, ma
; CHECK-NEXT:    vfsqrt.v v8, v8
; CHECK-NEXT:    ret
  %r = call <vscale x 8 x double> @llvm.experimental.constrained.sqrt.nxv8f64(<vscale x 8 x double> %v, metadata !"round.dynamic", metadata !"fpexcept.strict")
  ret <vscale x 8 x double> %r
}
