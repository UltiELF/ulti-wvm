; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

; EXTRACT VECTOR ELT

define i32 @promote_extract_2i32_idx(<vscale x 2 x i32> %a, i32 %idx) {
; CHECK-LABEL: promote_extract_2i32_idx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, w0
; CHECK-NEXT:    whilels p0.d, xzr, x8
; CHECK-NEXT:    lastb x0, p0, z0.d
; CHECK-NEXT:    // kill: def $w0 killed $w0 killed $x0
; CHECK-NEXT:    ret
  %ext = extractelement <vscale x 2 x i32> %a, i32 %idx
  ret i32 %ext
}

define i8 @split_extract_32i8_idx(<vscale x 32 x i8> %a, i32 %idx) {
; CHECK-LABEL: split_extract_32i8_idx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    rdvl x8, #2
; CHECK-NEXT:    mov w9, w0
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    cmp x9, x8
; CHECK-NEXT:    csel x8, x9, x8, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    st1b { z1.b }, p0, [sp, #1, mul vl]
; CHECK-NEXT:    st1b { z0.b }, p0, [sp]
; CHECK-NEXT:    ldrb w0, [x9, x8]
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %ext = extractelement <vscale x 32 x i8> %a, i32 %idx
  ret i8 %ext
}

define i16 @split_extract_16i16_idx(<vscale x 16 x i16> %a, i32 %idx) {
; CHECK-LABEL: split_extract_16i16_idx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    mov w9, w0
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    cmp x9, x8
; CHECK-NEXT:    csel x8, x9, x8, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    st1h { z1.h }, p0, [sp, #1, mul vl]
; CHECK-NEXT:    st1h { z0.h }, p0, [sp]
; CHECK-NEXT:    ldrh w0, [x9, x8, lsl #1]
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %ext = extractelement <vscale x 16 x i16> %a, i32 %idx
  ret i16 %ext
}

define i32 @split_extract_8i32_idx(<vscale x 8 x i32> %a, i32 %idx) {
; CHECK-LABEL: split_extract_8i32_idx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    cnth x8
; CHECK-NEXT:    mov w9, w0
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    cmp x9, x8
; CHECK-NEXT:    csel x8, x9, x8, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    st1w { z1.s }, p0, [sp, #1, mul vl]
; CHECK-NEXT:    st1w { z0.s }, p0, [sp]
; CHECK-NEXT:    ldr w0, [x9, x8, lsl #2]
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %ext = extractelement <vscale x 8 x i32> %a, i32 %idx
  ret i32 %ext
}

define i64 @split_extract_8i64_idx(<vscale x 8 x i64> %a, i32 %idx) {
; CHECK-LABEL: split_extract_8i64_idx:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-4
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x20, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 32 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    cnth x8
; CHECK-NEXT:    mov w9, w0
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    cmp x9, x8
; CHECK-NEXT:    csel x8, x9, x8, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    st1d { z3.d }, p0, [sp, #3, mul vl]
; CHECK-NEXT:    st1d { z2.d }, p0, [sp, #2, mul vl]
; CHECK-NEXT:    st1d { z1.d }, p0, [sp, #1, mul vl]
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    ldr x0, [x9, x8, lsl #3]
; CHECK-NEXT:    addvl sp, sp, #4
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %ext = extractelement <vscale x 8 x i64> %a, i32 %idx
  ret i64 %ext
}

; EXTRACT VECTOR ELT, CONSTANT IDX

define i16 @promote_extract_4i16(<vscale x 4 x i16> %a) {
; CHECK-LABEL: promote_extract_4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w0, v0.s[1]
; CHECK-NEXT:    ret
  %ext = extractelement <vscale x 4 x i16> %a, i32 1
  ret i16 %ext
}

define i8 @split_extract_32i8(<vscale x 32 x i8> %a) {
; CHECK-LABEL: split_extract_32i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    umov w0, v0.b[3]
; CHECK-NEXT:    ret
  %ext = extractelement <vscale x 32 x i8> %a, i32 3
  ret i8 %ext
}

define i16 @split_extract_16i16(<vscale x 16 x i16> %a) {
; CHECK-LABEL: split_extract_16i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    mov w9, #128 // =0x80
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    cmp x8, #128
; CHECK-NEXT:    csel x8, x8, x9, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    st1h { z1.h }, p0, [sp, #1, mul vl]
; CHECK-NEXT:    st1h { z0.h }, p0, [sp]
; CHECK-NEXT:    ldrh w0, [x9, x8, lsl #1]
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %ext = extractelement <vscale x 16 x i16> %a, i32 128
  ret i16 %ext
}

define i32 @split_extract_16i32(<vscale x 16 x i32> %a) {
; CHECK-LABEL: split_extract_16i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-4
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x20, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 32 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    mov w9, #34464 // =0x86a0
; CHECK-NEXT:    movk w9, #1, lsl #16
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    cmp x8, x9
; CHECK-NEXT:    csel x8, x8, x9, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    st1w { z3.s }, p0, [sp, #3, mul vl]
; CHECK-NEXT:    st1w { z2.s }, p0, [sp, #2, mul vl]
; CHECK-NEXT:    st1w { z1.s }, p0, [sp, #1, mul vl]
; CHECK-NEXT:    st1w { z0.s }, p0, [sp]
; CHECK-NEXT:    ldr w0, [x9, x8, lsl #2]
; CHECK-NEXT:    addvl sp, sp, #4
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %ext = extractelement <vscale x 16 x i32> %a, i32 100000
  ret i32 %ext
}

define i64 @split_extract_4i64(<vscale x 4 x i64> %a) {
; CHECK-LABEL: split_extract_4i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-2
; CHECK-NEXT:    .cfi_escape 0x0f, 0x0c, 0x8f, 0x00, 0x11, 0x10, 0x22, 0x11, 0x10, 0x92, 0x2e, 0x00, 0x1e, 0x22 // sp + 16 + 16 * VG
; CHECK-NEXT:    .cfi_offset w29, -16
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    cntw x8
; CHECK-NEXT:    mov w9, #10 // =0xa
; CHECK-NEXT:    sub x8, x8, #1
; CHECK-NEXT:    cmp x8, #10
; CHECK-NEXT:    csel x8, x8, x9, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    st1d { z1.d }, p0, [sp, #1, mul vl]
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    ldr x0, [x9, x8, lsl #3]
; CHECK-NEXT:    addvl sp, sp, #2
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %ext = extractelement <vscale x 4 x i64> %a, i32 10
  ret i64 %ext
}
