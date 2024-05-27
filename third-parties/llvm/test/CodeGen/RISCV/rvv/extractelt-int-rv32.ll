; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32NOM
; RUN: llc -mtriple=riscv32 -mattr=+d,+zfh,+zvfh,+v,+m -target-abi=ilp32d \
; RUN:     -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK,RV32M


define signext i8 @extractelt_nxv1i8_0(<vscale x 1 x i8> %v) {
; CHECK-LABEL: extractelt_nxv1i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i8> %v, i32 0
  ret i8 %r
}

define signext i8 @extractelt_nxv1i8_imm(<vscale x 1 x i8> %v) {
; CHECK-LABEL: extractelt_nxv1i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i8> %v, i32 2
  ret i8 %r
}

define signext i8 @extractelt_nxv1i8_idx(<vscale x 1 x i8> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv1i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf8, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i8> %v, i32 %idx
  ret i8 %r
}

define signext i8 @extractelt_nxv2i8_0(<vscale x 2 x i8> %v) {
; CHECK-LABEL: extractelt_nxv2i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i8> %v, i32 0
  ret i8 %r
}

define signext i8 @extractelt_nxv2i8_imm(<vscale x 2 x i8> %v) {
; CHECK-LABEL: extractelt_nxv2i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i8> %v, i32 2
  ret i8 %r
}

define signext i8 @extractelt_nxv2i8_idx(<vscale x 2 x i8> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv2i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i8> %v, i32 %idx
  ret i8 %r
}

define signext i8 @extractelt_nxv4i8_0(<vscale x 4 x i8> %v) {
; CHECK-LABEL: extractelt_nxv4i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i8> %v, i32 0
  ret i8 %r
}

define signext i8 @extractelt_nxv4i8_imm(<vscale x 4 x i8> %v) {
; CHECK-LABEL: extractelt_nxv4i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i8> %v, i32 2
  ret i8 %r
}

define signext i8 @extractelt_nxv4i8_idx(<vscale x 4 x i8> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv4i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i8> %v, i32 %idx
  ret i8 %r
}

define signext i8 @extractelt_nxv8i8_0(<vscale x 8 x i8> %v) {
; CHECK-LABEL: extractelt_nxv8i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i8> %v, i32 0
  ret i8 %r
}

define signext i8 @extractelt_nxv8i8_imm(<vscale x 8 x i8> %v) {
; CHECK-LABEL: extractelt_nxv8i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i8> %v, i32 2
  ret i8 %r
}

define signext i8 @extractelt_nxv8i8_idx(<vscale x 8 x i8> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv8i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i8> %v, i32 %idx
  ret i8 %r
}

define signext i8 @extractelt_nxv16i8_0(<vscale x 16 x i8> %v) {
; CHECK-LABEL: extractelt_nxv16i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x i8> %v, i32 0
  ret i8 %r
}

define signext i8 @extractelt_nxv16i8_imm(<vscale x 16 x i8> %v) {
; CHECK-LABEL: extractelt_nxv16i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x i8> %v, i32 2
  ret i8 %r
}

define signext i8 @extractelt_nxv16i8_idx(<vscale x 16 x i8> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv16i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m2, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x i8> %v, i32 %idx
  ret i8 %r
}

define signext i8 @extractelt_nxv32i8_0(<vscale x 32 x i8> %v) {
; CHECK-LABEL: extractelt_nxv32i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x i8> %v, i32 0
  ret i8 %r
}

define signext i8 @extractelt_nxv32i8_imm(<vscale x 32 x i8> %v) {
; CHECK-LABEL: extractelt_nxv32i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x i8> %v, i32 2
  ret i8 %r
}

define signext i8 @extractelt_nxv32i8_idx(<vscale x 32 x i8> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv32i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m4, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x i8> %v, i32 %idx
  ret i8 %r
}

define signext i8 @extractelt_nxv64i8_0(<vscale x 64 x i8> %v) {
; CHECK-LABEL: extractelt_nxv64i8_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 64 x i8> %v, i32 0
  ret i8 %r
}

define signext i8 @extractelt_nxv64i8_imm(<vscale x 64 x i8> %v) {
; CHECK-LABEL: extractelt_nxv64i8_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 64 x i8> %v, i32 2
  ret i8 %r
}

define signext i8 @extractelt_nxv64i8_idx(<vscale x 64 x i8> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv64i8_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e8, m8, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 64 x i8> %v, i32 %idx
  ret i8 %r
}

define signext i16 @extractelt_nxv1i16_0(<vscale x 1 x i16> %v) {
; CHECK-LABEL: extractelt_nxv1i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i16> %v, i32 0
  ret i16 %r
}

define signext i16 @extractelt_nxv1i16_imm(<vscale x 1 x i16> %v) {
; CHECK-LABEL: extractelt_nxv1i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i16> %v, i32 2
  ret i16 %r
}

define signext i16 @extractelt_nxv1i16_idx(<vscale x 1 x i16> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv1i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i16> %v, i32 %idx
  ret i16 %r
}

define signext i16 @extractelt_nxv2i16_0(<vscale x 2 x i16> %v) {
; CHECK-LABEL: extractelt_nxv2i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i16> %v, i32 0
  ret i16 %r
}

define signext i16 @extractelt_nxv2i16_imm(<vscale x 2 x i16> %v) {
; CHECK-LABEL: extractelt_nxv2i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i16> %v, i32 2
  ret i16 %r
}

define signext i16 @extractelt_nxv2i16_idx(<vscale x 2 x i16> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv2i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i16> %v, i32 %idx
  ret i16 %r
}

define signext i16 @extractelt_nxv4i16_0(<vscale x 4 x i16> %v) {
; CHECK-LABEL: extractelt_nxv4i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i16> %v, i32 0
  ret i16 %r
}

define signext i16 @extractelt_nxv4i16_imm(<vscale x 4 x i16> %v) {
; CHECK-LABEL: extractelt_nxv4i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i16> %v, i32 2
  ret i16 %r
}

define signext i16 @extractelt_nxv4i16_idx(<vscale x 4 x i16> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv4i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i16> %v, i32 %idx
  ret i16 %r
}

define signext i16 @extractelt_nxv8i16_0(<vscale x 8 x i16> %v) {
; CHECK-LABEL: extractelt_nxv8i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i16> %v, i32 0
  ret i16 %r
}

define signext i16 @extractelt_nxv8i16_imm(<vscale x 8 x i16> %v) {
; CHECK-LABEL: extractelt_nxv8i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i16> %v, i32 2
  ret i16 %r
}

define signext i16 @extractelt_nxv8i16_idx(<vscale x 8 x i16> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv8i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m2, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i16> %v, i32 %idx
  ret i16 %r
}

define signext i16 @extractelt_nxv16i16_0(<vscale x 16 x i16> %v) {
; CHECK-LABEL: extractelt_nxv16i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x i16> %v, i32 0
  ret i16 %r
}

define signext i16 @extractelt_nxv16i16_imm(<vscale x 16 x i16> %v) {
; CHECK-LABEL: extractelt_nxv16i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x i16> %v, i32 2
  ret i16 %r
}

define signext i16 @extractelt_nxv16i16_idx(<vscale x 16 x i16> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv16i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m4, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x i16> %v, i32 %idx
  ret i16 %r
}

define signext i16 @extractelt_nxv32i16_0(<vscale x 32 x i16> %v) {
; CHECK-LABEL: extractelt_nxv32i16_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x i16> %v, i32 0
  ret i16 %r
}

define signext i16 @extractelt_nxv32i16_imm(<vscale x 32 x i16> %v) {
; CHECK-LABEL: extractelt_nxv32i16_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x i16> %v, i32 2
  ret i16 %r
}

define signext i16 @extractelt_nxv32i16_idx(<vscale x 32 x i16> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv32i16_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e16, m8, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x i16> %v, i32 %idx
  ret i16 %r
}

define i32 @extractelt_nxv1i32_0(<vscale x 1 x i32> %v) {
; CHECK-LABEL: extractelt_nxv1i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i32> %v, i32 0
  ret i32 %r
}

define i32 @extractelt_nxv1i32_imm(<vscale x 1 x i32> %v) {
; CHECK-LABEL: extractelt_nxv1i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i32> %v, i32 2
  ret i32 %r
}

define i32 @extractelt_nxv1i32_idx(<vscale x 1 x i32> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv1i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, mf2, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i32> %v, i32 %idx
  ret i32 %r
}

define i32 @extractelt_nxv2i32_0(<vscale x 2 x i32> %v) {
; CHECK-LABEL: extractelt_nxv2i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i32> %v, i32 0
  ret i32 %r
}

define i32 @extractelt_nxv2i32_imm(<vscale x 2 x i32> %v) {
; CHECK-LABEL: extractelt_nxv2i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i32> %v, i32 2
  ret i32 %r
}

define i32 @extractelt_nxv2i32_idx(<vscale x 2 x i32> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv2i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i32> %v, i32 %idx
  ret i32 %r
}

define i32 @extractelt_nxv4i32_0(<vscale x 4 x i32> %v) {
; CHECK-LABEL: extractelt_nxv4i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i32> %v, i32 0
  ret i32 %r
}

define i32 @extractelt_nxv4i32_imm(<vscale x 4 x i32> %v) {
; CHECK-LABEL: extractelt_nxv4i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i32> %v, i32 2
  ret i32 %r
}

define i32 @extractelt_nxv4i32_idx(<vscale x 4 x i32> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv4i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m2, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i32> %v, i32 %idx
  ret i32 %r
}

define i32 @extractelt_nxv8i32_0(<vscale x 8 x i32> %v) {
; CHECK-LABEL: extractelt_nxv8i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i32> %v, i32 0
  ret i32 %r
}

define i32 @extractelt_nxv8i32_imm(<vscale x 8 x i32> %v) {
; CHECK-LABEL: extractelt_nxv8i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i32> %v, i32 2
  ret i32 %r
}

define i32 @extractelt_nxv8i32_idx(<vscale x 8 x i32> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv8i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m4, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i32> %v, i32 %idx
  ret i32 %r
}

define i32 @extractelt_nxv16i32_0(<vscale x 16 x i32> %v) {
; CHECK-LABEL: extractelt_nxv16i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x i32> %v, i32 0
  ret i32 %r
}

define i32 @extractelt_nxv16i32_imm(<vscale x 16 x i32> %v) {
; CHECK-LABEL: extractelt_nxv16i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x i32> %v, i32 2
  ret i32 %r
}

define i32 @extractelt_nxv16i32_idx(<vscale x 16 x i32> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv16i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m8, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x i32> %v, i32 %idx
  ret i32 %r
}

define i64 @extractelt_nxv1i64_0(<vscale x 1 x i64> %v) {
; CHECK-LABEL: extractelt_nxv1i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vsrl.vx v9, v8, a0
; CHECK-NEXT:    vmv.x.s a1, v9
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i64> %v, i32 0
  ret i64 %r
}

define i64 @extractelt_nxv1i64_imm(<vscale x 1 x i64> %v) {
; CHECK-LABEL: extractelt_nxv1i64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsrl.vx v9, v8, a0
; CHECK-NEXT:    vmv.x.s a1, v9
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i64> %v, i32 2
  ret i64 %r
}

define i64 @extractelt_nxv1i64_idx(<vscale x 1 x i64> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv1i64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m1, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsrl.vx v8, v8, a1
; CHECK-NEXT:    vmv.x.s a1, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 1 x i64> %v, i32 %idx
  ret i64 %r
}

define i64 @extractelt_nxv2i64_0(<vscale x 2 x i64> %v) {
; CHECK-LABEL: extractelt_nxv2i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; CHECK-NEXT:    vsrl.vx v10, v8, a0
; CHECK-NEXT:    vmv.x.s a1, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i64> %v, i32 0
  ret i64 %r
}

define i64 @extractelt_nxv2i64_imm(<vscale x 2 x i64> %v) {
; CHECK-LABEL: extractelt_nxv2i64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsrl.vx v10, v8, a0
; CHECK-NEXT:    vmv.x.s a1, v10
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i64> %v, i32 2
  ret i64 %r
}

define i64 @extractelt_nxv2i64_idx(<vscale x 2 x i64> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv2i64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m2, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsrl.vx v8, v8, a1
; CHECK-NEXT:    vmv.x.s a1, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 2 x i64> %v, i32 %idx
  ret i64 %r
}

define i64 @extractelt_nxv4i64_0(<vscale x 4 x i64> %v) {
; CHECK-LABEL: extractelt_nxv4i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; CHECK-NEXT:    vsrl.vx v12, v8, a0
; CHECK-NEXT:    vmv.x.s a1, v12
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i64> %v, i32 0
  ret i64 %r
}

define i64 @extractelt_nxv4i64_imm(<vscale x 4 x i64> %v) {
; CHECK-LABEL: extractelt_nxv4i64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsrl.vx v12, v8, a0
; CHECK-NEXT:    vmv.x.s a1, v12
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i64> %v, i32 2
  ret i64 %r
}

define i64 @extractelt_nxv4i64_idx(<vscale x 4 x i64> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv4i64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m4, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsrl.vx v8, v8, a1
; CHECK-NEXT:    vmv.x.s a1, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 4 x i64> %v, i32 %idx
  ret i64 %r
}

define i64 @extractelt_nxv8i64_0(<vscale x 8 x i64> %v) {
; CHECK-LABEL: extractelt_nxv8i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsetivli zero, 1, e64, m8, ta, ma
; CHECK-NEXT:    vsrl.vx v16, v8, a0
; CHECK-NEXT:    vmv.x.s a1, v16
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i64> %v, i32 0
  ret i64 %r
}

define i64 @extractelt_nxv8i64_imm(<vscale x 8 x i64> %v) {
; CHECK-LABEL: extractelt_nxv8i64_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m8, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    li a0, 32
; CHECK-NEXT:    vsrl.vx v16, v8, a0
; CHECK-NEXT:    vmv.x.s a1, v16
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i64> %v, i32 2
  ret i64 %r
}

define i64 @extractelt_nxv8i64_idx(<vscale x 8 x i64> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv8i64_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e64, m8, ta, ma
; CHECK-NEXT:    vslidedown.vx v8, v8, a0
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    li a1, 32
; CHECK-NEXT:    vsrl.vx v8, v8, a1
; CHECK-NEXT:    vmv.x.s a1, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 8 x i64> %v, i32 %idx
  ret i64 %r
}

define i32 @extractelt_add_nxv4i32_splat(<vscale x 4 x i32> %x) {
; CHECK-LABEL: extractelt_add_nxv4i32_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    addi a0, a0, 3
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 3, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %bo = add <vscale x 4 x i32> %x, %splat
  %ext = extractelement <vscale x 4 x i32> %bo, i32 2
  ret i32 %ext
}

define i32 @extractelt_sub_nxv4i32_splat(<vscale x 4 x i32> %x) {
; CHECK-LABEL: extractelt_sub_nxv4i32_splat:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 1
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    li a1, 3
; CHECK-NEXT:    sub a0, a1, a0
; CHECK-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 3, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %bo = sub <vscale x 4 x i32> %splat, %x
  %ext = extractelement <vscale x 4 x i32> %bo, i32 1
  ret i32 %ext
}

define i32 @extractelt_mul_nxv4i32_splat(<vscale x 4 x i32> %x) {
; RV32NOM-LABEL: extractelt_mul_nxv4i32_splat:
; RV32NOM:       # %bb.0:
; RV32NOM-NEXT:    li a0, 3
; RV32NOM-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; RV32NOM-NEXT:    vmul.vx v8, v8, a0
; RV32NOM-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; RV32NOM-NEXT:    vslidedown.vi v8, v8, 3
; RV32NOM-NEXT:    vmv.x.s a0, v8
; RV32NOM-NEXT:    ret
;
; RV32M-LABEL: extractelt_mul_nxv4i32_splat:
; RV32M:       # %bb.0:
; RV32M-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; RV32M-NEXT:    vslidedown.vi v8, v8, 3
; RV32M-NEXT:    vmv.x.s a0, v8
; RV32M-NEXT:    slli a1, a0, 1
; RV32M-NEXT:    add a0, a1, a0
; RV32M-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 3, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %bo = mul <vscale x 4 x i32> %x, %splat
  %ext = extractelement <vscale x 4 x i32> %bo, i32 3
  ret i32 %ext
}

define i32 @extractelt_sdiv_nxv4i32_splat(<vscale x 4 x i32> %x) {
; RV32NOM-LABEL: extractelt_sdiv_nxv4i32_splat:
; RV32NOM:       # %bb.0:
; RV32NOM-NEXT:    lui a0, 349525
; RV32NOM-NEXT:    addi a0, a0, 1366
; RV32NOM-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; RV32NOM-NEXT:    vmulh.vx v8, v8, a0
; RV32NOM-NEXT:    vsrl.vi v10, v8, 31
; RV32NOM-NEXT:    vadd.vv v8, v8, v10
; RV32NOM-NEXT:    vmv.x.s a0, v8
; RV32NOM-NEXT:    ret
;
; RV32M-LABEL: extractelt_sdiv_nxv4i32_splat:
; RV32M:       # %bb.0:
; RV32M-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; RV32M-NEXT:    vmv.x.s a0, v8
; RV32M-NEXT:    lui a1, 349525
; RV32M-NEXT:    addi a1, a1, 1366
; RV32M-NEXT:    mulh a0, a0, a1
; RV32M-NEXT:    srli a1, a0, 31
; RV32M-NEXT:    add a0, a0, a1
; RV32M-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 3, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %bo = sdiv <vscale x 4 x i32> %x, %splat
  %ext = extractelement <vscale x 4 x i32> %bo, i32 0
  ret i32 %ext
}

define i32 @extractelt_udiv_nxv4i32_splat(<vscale x 4 x i32> %x) {
; RV32NOM-LABEL: extractelt_udiv_nxv4i32_splat:
; RV32NOM:       # %bb.0:
; RV32NOM-NEXT:    lui a0, 349525
; RV32NOM-NEXT:    addi a0, a0, 1366
; RV32NOM-NEXT:    vsetvli a1, zero, e32, m2, ta, ma
; RV32NOM-NEXT:    vmulh.vx v8, v8, a0
; RV32NOM-NEXT:    vsrl.vi v10, v8, 31
; RV32NOM-NEXT:    vadd.vv v8, v8, v10
; RV32NOM-NEXT:    vmv.x.s a0, v8
; RV32NOM-NEXT:    ret
;
; RV32M-LABEL: extractelt_udiv_nxv4i32_splat:
; RV32M:       # %bb.0:
; RV32M-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; RV32M-NEXT:    vmv.x.s a0, v8
; RV32M-NEXT:    lui a1, 349525
; RV32M-NEXT:    addi a1, a1, 1366
; RV32M-NEXT:    mulh a0, a0, a1
; RV32M-NEXT:    srli a1, a0, 31
; RV32M-NEXT:    add a0, a0, a1
; RV32M-NEXT:    ret
  %head = insertelement <vscale x 4 x i32> poison, i32 3, i32 0
  %splat = shufflevector <vscale x 4 x i32> %head, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %bo = sdiv <vscale x 4 x i32> %x, %splat
  %ext = extractelement <vscale x 4 x i32> %bo, i32 0
  ret i32 %ext
}

define i32 @extractelt_nxv32i32_0(<vscale x 32 x i32> %v) {
; CHECK-LABEL: extractelt_nxv32i32_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x i32> %v, i32 0
  ret i32 %r
}

define i32 @extractelt_nxv32i32_neg1(<vscale x 32 x i32> %v) {
; CHECK-LABEL: extractelt_nxv32i32_neg1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi sp, sp, -80
; CHECK-NEXT:    .cfi_def_cfa_offset 80
; CHECK-NEXT:    sw ra, 76(sp) # 4-byte Folded Spill
; CHECK-NEXT:    sw s0, 72(sp) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset ra, -4
; CHECK-NEXT:    .cfi_offset s0, -8
; CHECK-NEXT:    addi s0, sp, 80
; CHECK-NEXT:    .cfi_def_cfa s0, 0
; CHECK-NEXT:    csrr a0, vlenb
; CHECK-NEXT:    slli a0, a0, 4
; CHECK-NEXT:    sub sp, sp, a0
; CHECK-NEXT:    andi sp, sp, -64
; CHECK-NEXT:    addi a0, sp, 64
; CHECK-NEXT:    vs8r.v v8, (a0)
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a2, a1, 3
; CHECK-NEXT:    add a2, a0, a2
; CHECK-NEXT:    vs8r.v v16, (a2)
; CHECK-NEXT:    slli a1, a1, 4
; CHECK-NEXT:    add a0, a1, a0
; CHECK-NEXT:    lw a0, -4(a0)
; CHECK-NEXT:    addi sp, s0, -80
; CHECK-NEXT:    lw ra, 76(sp) # 4-byte Folded Reload
; CHECK-NEXT:    lw s0, 72(sp) # 4-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 80
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x i32> %v, i32 -1
  ret i32 %r
}

define i32 @extractelt_nxv32i32_imm(<vscale x 32 x i32> %v) {
; CHECK-LABEL: extractelt_nxv32i32_imm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vslidedown.vi v8, v8, 2
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x i32> %v, i32 2
  ret i32 %r
}

define i32 @extractelt_nxv32i32_idx(<vscale x 32 x i32> %v, i32 %idx) {
; CHECK-LABEL: extractelt_nxv32i32_idx:
; CHECK:       # %bb.0:
; CHECK-NEXT:    csrr a1, vlenb
; CHECK-NEXT:    slli a2, a1, 2
; CHECK-NEXT:    addi a2, a2, -1
; CHECK-NEXT:    bltu a0, a2, .LBB74_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    mv a0, a2
; CHECK-NEXT:  .LBB74_2:
; CHECK-NEXT:    addi sp, sp, -80
; CHECK-NEXT:    .cfi_def_cfa_offset 80
; CHECK-NEXT:    sw ra, 76(sp) # 4-byte Folded Spill
; CHECK-NEXT:    sw s0, 72(sp) # 4-byte Folded Spill
; CHECK-NEXT:    .cfi_offset ra, -4
; CHECK-NEXT:    .cfi_offset s0, -8
; CHECK-NEXT:    addi s0, sp, 80
; CHECK-NEXT:    .cfi_def_cfa s0, 0
; CHECK-NEXT:    csrr a2, vlenb
; CHECK-NEXT:    slli a2, a2, 4
; CHECK-NEXT:    sub sp, sp, a2
; CHECK-NEXT:    andi sp, sp, -64
; CHECK-NEXT:    slli a0, a0, 2
; CHECK-NEXT:    addi a2, sp, 64
; CHECK-NEXT:    add a0, a2, a0
; CHECK-NEXT:    vs8r.v v8, (a2)
; CHECK-NEXT:    slli a1, a1, 3
; CHECK-NEXT:    add a1, a2, a1
; CHECK-NEXT:    vs8r.v v16, (a1)
; CHECK-NEXT:    lw a0, 0(a0)
; CHECK-NEXT:    addi sp, s0, -80
; CHECK-NEXT:    lw ra, 76(sp) # 4-byte Folded Reload
; CHECK-NEXT:    lw s0, 72(sp) # 4-byte Folded Reload
; CHECK-NEXT:    addi sp, sp, 80
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 32 x i32> %v, i32 %idx
  ret i32 %r
}

define i64 @extractelt_nxv16i64_0(<vscale x 16 x i64> %v) {
; CHECK-LABEL: extractelt_nxv16i64_0:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli zero, 1, e32, m1, ta, ma
; CHECK-NEXT:    vmv.x.s a0, v8
; CHECK-NEXT:    vslidedown.vi v8, v8, 1
; CHECK-NEXT:    vmv.x.s a1, v8
; CHECK-NEXT:    ret
  %r = extractelement <vscale x 16 x i64> %v, i32 0
  ret i64 %r
}
