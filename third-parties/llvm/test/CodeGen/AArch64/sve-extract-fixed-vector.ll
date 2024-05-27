; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve,+bf16 < %s | FileCheck %s --check-prefixes=CHECK

; Should codegen to a nop, since idx is zero.
define <2 x i64> @extract_v2i64_nxv2i64(<vscale x 2 x i64> %vec) nounwind {
; CHECK-LABEL: extract_v2i64_nxv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %retval = call <2 x i64> @llvm.vector.extract.v2i64.nxv2i64(<vscale x 2 x i64> %vec, i64 0)
  ret <2 x i64> %retval
}

; Goes through memory currently; idx != 0.
define <2 x i64> @extract_v2i64_nxv2i64_idx2(<vscale x 2 x i64> %vec) nounwind {
; CHECK-LABEL: extract_v2i64_nxv2i64_idx2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    cntd x8
; CHECK-NEXT:    mov w9, #2 // =0x2
; CHECK-NEXT:    sub x8, x8, #2
; CHECK-NEXT:    cmp x8, #2
; CHECK-NEXT:    csel x8, x8, x9, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    lsl x8, x8, #3
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    ldr q0, [x9, x8]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <2 x i64> @llvm.vector.extract.v2i64.nxv2i64(<vscale x 2 x i64> %vec, i64 2)
  ret <2 x i64> %retval
}

; Should codegen to a nop, since idx is zero.
define <4 x i32> @extract_v4i32_nxv4i32(<vscale x 4 x i32> %vec) nounwind {
; CHECK-LABEL: extract_v4i32_nxv4i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %retval = call <4 x i32> @llvm.vector.extract.v4i32.nxv4i32(<vscale x 4 x i32> %vec, i64 0)
  ret <4 x i32> %retval
}

; Goes through memory currently; idx != 0.
define <4 x i32> @extract_v4i32_nxv4i32_idx4(<vscale x 4 x i32> %vec) nounwind {
; CHECK-LABEL: extract_v4i32_nxv4i32_idx4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    cntw x8
; CHECK-NEXT:    mov w9, #4 // =0x4
; CHECK-NEXT:    sub x8, x8, #4
; CHECK-NEXT:    cmp x8, #4
; CHECK-NEXT:    csel x8, x8, x9, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    lsl x8, x8, #2
; CHECK-NEXT:    st1w { z0.s }, p0, [sp]
; CHECK-NEXT:    ldr q0, [x9, x8]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <4 x i32> @llvm.vector.extract.v4i32.nxv4i32(<vscale x 4 x i32> %vec, i64 4)
  ret <4 x i32> %retval
}

; Should codegen to uzps, since idx is zero and type is illegal.
define <4 x i32> @extract_v4i32_nxv2i32(<vscale x 2 x i32> %vec) nounwind #1 {
; CHECK-LABEL: extract_v4i32_nxv2i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 z0.s, z0.s, z0.s
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %retval = call <4 x i32> @llvm.vector.extract.v4i32.nxv2i32(<vscale x 2 x i32> %vec, i64 0)
  ret <4 x i32> %retval
}

; Goes through memory currently; idx != 0.
define <4 x i32> @extract_v4i32_nxv2i32_idx4(<vscale x 2 x i32> %vec) nounwind #1 {
; CHECK-LABEL: extract_v4i32_nxv2i32_idx4:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov x8, #4 // =0x4
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    ptrue p1.d, vl4
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    ld1d { z0.d }, p1/z, [x9, x8, lsl #3]
; CHECK-NEXT:    uzp1 z0.s, z0.s, z0.s
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <4 x i32> @llvm.vector.extract.v4i32.nxv2i32(<vscale x 2 x i32> %vec, i64 4)
  ret <4 x i32> %retval
}

; Should codegen to a nop, since idx is zero.
define <8 x i16> @extract_v8i16_nxv8i16(<vscale x 8 x i16> %vec) nounwind {
; CHECK-LABEL: extract_v8i16_nxv8i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %retval = call <8 x i16> @llvm.vector.extract.v8i16.nxv8i16(<vscale x 8 x i16> %vec, i64 0)
  ret <8 x i16> %retval
}

; Goes through memory currently; idx != 0.
define <8 x i16> @extract_v8i16_nxv8i16_idx8(<vscale x 8 x i16> %vec) nounwind {
; CHECK-LABEL: extract_v8i16_nxv8i16_idx8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    cnth x8
; CHECK-NEXT:    mov w9, #8 // =0x8
; CHECK-NEXT:    sub x8, x8, #8
; CHECK-NEXT:    cmp x8, #8
; CHECK-NEXT:    csel x8, x8, x9, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    lsl x8, x8, #1
; CHECK-NEXT:    st1h { z0.h }, p0, [sp]
; CHECK-NEXT:    ldr q0, [x9, x8]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <8 x i16> @llvm.vector.extract.v8i16.nxv8i16(<vscale x 8 x i16> %vec, i64 8)
  ret <8 x i16> %retval
}

; Should codegen to uzps, since idx is zero and type is illegal.
define <8 x i16> @extract_v8i16_nxv4i16(<vscale x 4 x i16> %vec) nounwind #1 {
; CHECK-LABEL: extract_v8i16_nxv4i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %retval = call <8 x i16> @llvm.vector.extract.v8i16.nxv4i16(<vscale x 4 x i16> %vec, i64 0)
  ret <8 x i16> %retval
}

; Goes through memory currently; idx != 0.
define <8 x i16> @extract_v8i16_nxv4i16_idx8(<vscale x 4 x i16> %vec) nounwind #1 {
; CHECK-LABEL: extract_v8i16_nxv4i16_idx8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov x8, #8 // =0x8
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    ptrue p1.s, vl8
; CHECK-NEXT:    st1w { z0.s }, p0, [sp]
; CHECK-NEXT:    ld1w { z0.s }, p1/z, [x9, x8, lsl #2]
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <8 x i16> @llvm.vector.extract.v8i16.nxv4i16(<vscale x 4 x i16> %vec, i64 8)
  ret <8 x i16> %retval
}

; Should codegen to uzps, since idx is zero and type is illegal.
define <8 x i16> @extract_v8i16_nxv2i16(<vscale x 2 x i16> %vec) nounwind #1 {
; CHECK-LABEL: extract_v8i16_nxv2i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 z0.s, z0.s, z0.s
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %retval = call <8 x i16> @llvm.vector.extract.v8i16.nxv2i16(<vscale x 2 x i16> %vec, i64 0)
  ret <8 x i16> %retval
}

; Goes through memory currently; idx != 0.
define <8 x i16> @extract_v8i16_nxv2i16_idx8(<vscale x 2 x i16> %vec) nounwind #1 {
; CHECK-LABEL: extract_v8i16_nxv2i16_idx8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    mov x8, #8 // =0x8
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    ptrue p1.d, vl8
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    ld1d { z0.d }, p1/z, [x9, x8, lsl #3]
; CHECK-NEXT:    uzp1 z0.s, z0.s, z0.s
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <8 x i16> @llvm.vector.extract.v8i16.nxv2i16(<vscale x 2 x i16> %vec, i64 8)
  ret <8 x i16> %retval
}

; Should codegen to a nop, since idx is zero.
define <16 x i8> @extract_v16i8_nxv16i8(<vscale x 16 x i8> %vec) nounwind {
; CHECK-LABEL: extract_v16i8_nxv16i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %retval = call <16 x i8> @llvm.vector.extract.v16i8.nxv16i8(<vscale x 16 x i8> %vec, i64 0)
  ret <16 x i8> %retval
}

; Goes through memory currently; idx != 0.
define <16 x i8> @extract_v16i8_nxv16i8_idx16(<vscale x 16 x i8> %vec) nounwind {
; CHECK-LABEL: extract_v16i8_nxv16i8_idx16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.b
; CHECK-NEXT:    rdvl x8, #1
; CHECK-NEXT:    mov w9, #16 // =0x10
; CHECK-NEXT:    sub x8, x8, #16
; CHECK-NEXT:    cmp x8, #16
; CHECK-NEXT:    csel x8, x8, x9, lo
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    st1b { z0.b }, p0, [sp]
; CHECK-NEXT:    ldr q0, [x9, x8]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <16 x i8> @llvm.vector.extract.v16i8.nxv16i8(<vscale x 16 x i8> %vec, i64 16)
  ret <16 x i8> %retval
}

; Should codegen to uzps, since idx is zero and type is illegal.
define <16 x i8> @extract_v16i8_nxv8i8(<vscale x 8 x i8> %vec) nounwind #1 {
; CHECK-LABEL: extract_v16i8_nxv8i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %retval = call <16 x i8> @llvm.vector.extract.v16i8.nxv8i8(<vscale x 8 x i8> %vec, i64 0)
  ret <16 x i8> %retval
}

; Goes through memory currently; idx != 0.
define <16 x i8> @extract_v16i8_nxv8i8_idx16(<vscale x 8 x i8> %vec) nounwind #1 {
; CHECK-LABEL: extract_v16i8_nxv8i8_idx16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.h
; CHECK-NEXT:    mov x8, #16 // =0x10
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    ptrue p1.h, vl16
; CHECK-NEXT:    st1h { z0.h }, p0, [sp]
; CHECK-NEXT:    ld1h { z0.h }, p1/z, [x9, x8, lsl #1]
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <16 x i8> @llvm.vector.extract.v16i8.nxv8i8(<vscale x 8 x i8> %vec, i64 16)
  ret <16 x i8> %retval
}

; Should codegen to uzps, since idx is zero and type is illegal.
define <16 x i8> @extract_v16i8_nxv4i8(<vscale x 4 x i8> %vec) nounwind #1 {
; CHECK-LABEL: extract_v16i8_nxv4i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %retval = call <16 x i8> @llvm.vector.extract.v16i8.nxv4i8(<vscale x 4 x i8> %vec, i64 0)
  ret <16 x i8> %retval
}

; Goes through memory currently; idx != 0.
define <16 x i8> @extract_v16i8_nxv4i8_idx16(<vscale x 4 x i8> %vec) nounwind #1 {
; CHECK-LABEL: extract_v16i8_nxv4i8_idx16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov x8, #16 // =0x10
; CHECK-NEXT:    mov x9, sp
; CHECK-NEXT:    ptrue p1.s, vl16
; CHECK-NEXT:    st1w { z0.s }, p0, [sp]
; CHECK-NEXT:    ld1w { z0.s }, p1/z, [x9, x8, lsl #2]
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <16 x i8> @llvm.vector.extract.v16i8.nxv4i8(<vscale x 4 x i8> %vec, i64 16)
  ret <16 x i8> %retval
}

; Should codegen to uzps, since idx is zero and type is illegal.
define <16 x i8> @extract_v16i8_nxv2i8(<vscale x 2 x i8> %vec) nounwind #1 {
; CHECK-LABEL: extract_v16i8_nxv2i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    uzp1 z0.s, z0.s, z0.s
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
  %retval = call <16 x i8> @llvm.vector.extract.v16i8.nxv2i8(<vscale x 2 x i8> %vec, i64 0)
  ret <16 x i8> %retval
}

; Goes through memory currently; idx != 0.
define <16 x i8> @extract_v16i8_nxv2i8_idx16(<vscale x 2 x i8> %vec) nounwind #1 {
; CHECK-LABEL: extract_v16i8_nxv2i8_idx16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [sp]
; CHECK-NEXT:    uzp1 z0.s, z0.s, z0.s
; CHECK-NEXT:    uzp1 z0.h, z0.h, z0.h
; CHECK-NEXT:    uzp1 z0.b, z0.b, z0.b
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <16 x i8> @llvm.vector.extract.v16i8.nxv2i8(<vscale x 2 x i8> %vec, i64 16)
  ret <16 x i8> %retval
}


; Predicates

define <2 x i1> @extract_v2i1_nxv2i1(<vscale x 2 x i1> %inmask) {
; CHECK-LABEL: extract_v2i1_nxv2i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z0.d, p0/z, #1 // =0x1
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    mov x8, v0.d[1]
; CHECK-NEXT:    fmov s0, w0
; CHECK-NEXT:    mov v0.s[1], w8
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
  %mask = call <2 x i1> @llvm.vector.extract.v2i1.nxv2i1(<vscale x 2 x i1> %inmask, i64 0)
  ret <2 x i1> %mask
}

define <4 x i1> @extract_v4i1_nxv4i1(<vscale x 4 x i1> %inmask) {
; CHECK-LABEL: extract_v4i1_nxv4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.s, p0/z, #1 // =0x1
; CHECK-NEXT:    mov w8, v1.s[1]
; CHECK-NEXT:    mov v0.16b, v1.16b
; CHECK-NEXT:    mov w9, v1.s[2]
; CHECK-NEXT:    mov v0.h[1], w8
; CHECK-NEXT:    mov w8, v1.s[3]
; CHECK-NEXT:    mov v0.h[2], w9
; CHECK-NEXT:    mov v0.h[3], w8
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
  %mask = call <4 x i1> @llvm.vector.extract.v4i1.nxv4i1(<vscale x 4 x i1> %inmask, i64 0)
  ret <4 x i1> %mask
}

define <8 x i1> @extract_v8i1_nxv8i1(<vscale x 8 x i1> %inmask) {
; CHECK-LABEL: extract_v8i1_nxv8i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.h, p0/z, #1 // =0x1
; CHECK-NEXT:    umov w8, v1.h[1]
; CHECK-NEXT:    mov v0.16b, v1.16b
; CHECK-NEXT:    umov w9, v1.h[2]
; CHECK-NEXT:    mov v0.b[1], w8
; CHECK-NEXT:    umov w8, v1.h[3]
; CHECK-NEXT:    mov v0.b[2], w9
; CHECK-NEXT:    umov w9, v1.h[4]
; CHECK-NEXT:    mov v0.b[3], w8
; CHECK-NEXT:    umov w8, v1.h[5]
; CHECK-NEXT:    mov v0.b[4], w9
; CHECK-NEXT:    umov w9, v1.h[6]
; CHECK-NEXT:    mov v0.b[5], w8
; CHECK-NEXT:    umov w8, v1.h[7]
; CHECK-NEXT:    mov v0.b[6], w9
; CHECK-NEXT:    mov v0.b[7], w8
; CHECK-NEXT:    // kill: def $d0 killed $d0 killed $q0
; CHECK-NEXT:    ret
  %mask = call <8 x i1> @llvm.vector.extract.v8i1.nxv8i1(<vscale x 8 x i1> %inmask, i64 0)
  ret <8 x i1> %mask
}

define <16 x i1> @extract_v16i1_nxv16i1(<vscale x 16 x i1> %inmask) {
; CHECK-LABEL: extract_v16i1_nxv16i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov z1.b, p0/z, #1 // =0x1
; CHECK-NEXT:    umov w8, v1.b[1]
; CHECK-NEXT:    mov v0.16b, v1.16b
; CHECK-NEXT:    umov w9, v1.b[2]
; CHECK-NEXT:    mov v0.b[1], w8
; CHECK-NEXT:    umov w8, v1.b[3]
; CHECK-NEXT:    mov v0.b[2], w9
; CHECK-NEXT:    umov w9, v1.b[4]
; CHECK-NEXT:    mov v0.b[3], w8
; CHECK-NEXT:    umov w8, v1.b[5]
; CHECK-NEXT:    mov v0.b[4], w9
; CHECK-NEXT:    umov w9, v1.b[6]
; CHECK-NEXT:    mov v0.b[5], w8
; CHECK-NEXT:    umov w8, v1.b[7]
; CHECK-NEXT:    mov v0.b[6], w9
; CHECK-NEXT:    umov w9, v1.b[8]
; CHECK-NEXT:    mov v0.b[7], w8
; CHECK-NEXT:    umov w8, v1.b[9]
; CHECK-NEXT:    mov v0.b[8], w9
; CHECK-NEXT:    umov w9, v1.b[10]
; CHECK-NEXT:    mov v0.b[9], w8
; CHECK-NEXT:    umov w8, v1.b[11]
; CHECK-NEXT:    mov v0.b[10], w9
; CHECK-NEXT:    umov w9, v1.b[12]
; CHECK-NEXT:    mov v0.b[11], w8
; CHECK-NEXT:    umov w8, v1.b[13]
; CHECK-NEXT:    mov v0.b[12], w9
; CHECK-NEXT:    umov w9, v1.b[14]
; CHECK-NEXT:    mov v0.b[13], w8
; CHECK-NEXT:    umov w8, v1.b[15]
; CHECK-NEXT:    mov v0.b[14], w9
; CHECK-NEXT:    mov v0.b[15], w8
; CHECK-NEXT:    ret
  %mask = call <16 x i1> @llvm.vector.extract.v16i1.nxv16i1(<vscale x 16 x i1> %inmask, i64 0)
  ret <16 x i1> %mask
}


; Fixed length clamping

define <2 x i64> @extract_fixed_v2i64_nxv2i64(<vscale x 2 x i64> %vec) nounwind #0 {
; CHECK-LABEL: extract_fixed_v2i64_nxv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    ldr q0, [sp, #16]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <2 x i64> @llvm.vector.extract.v2i64.nxv2i64(<vscale x 2 x i64> %vec, i64 2)
  ret <2 x i64> %retval
}

define void @extract_fixed_v4i64_nxv2i64(<vscale x 2 x i64> %vec, ptr %p) nounwind #0 {
; CHECK-LABEL: extract_fixed_v4i64_nxv2i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    str x29, [sp, #-16]! // 8-byte Folded Spill
; CHECK-NEXT:    addvl sp, sp, #-1
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    st1d { z0.d }, p0, [sp]
; CHECK-NEXT:    ld1d { z0.d }, p0/z, [sp]
; CHECK-NEXT:    st1d { z0.d }, p0, [x0]
; CHECK-NEXT:    addvl sp, sp, #1
; CHECK-NEXT:    ldr x29, [sp], #16 // 8-byte Folded Reload
; CHECK-NEXT:    ret
  %retval = call <4 x i64> @llvm.vector.extract.v4i64.nxv2i64(<vscale x 2 x i64> %vec, i64 4)
  store <4 x i64> %retval, ptr %p
  ret void
}

; Check that extract from load via bitcast-gep-of-scalar-ptr does not crash.
define <4 x i32> @typesize_regression_test_v4i32(i32* %addr, i64 %idx) {
; CHECK-LABEL: typesize_regression_test_v4i32:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    ld1w { z0.s }, p0/z, [x0, x1, lsl #2]
; CHECK-NEXT:    // kill: def $q0 killed $q0 killed $z0
; CHECK-NEXT:    ret
entry:
  %ptr = getelementptr inbounds i32, i32* %addr, i64 %idx
  %bc = bitcast i32* %ptr to <vscale x 4 x i32>*
  %ld = load volatile <vscale x 4 x i32>, <vscale x 4 x i32>* %bc, align 16
  %out = call <4 x i32> @llvm.vector.extract.v4i32.nxv4i32(<vscale x 4 x i32> %ld, i64 0)
  ret <4 x i32> %out
}

;
; Extract fixed-width vector from a scalable vector splat.
;

define <2 x float> @extract_v2f32_nxv4f32_splat(float %f) {
; CHECK-LABEL: extract_v2f32_nxv4f32_splat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEXT:    dup v0.2s, v0.s[0]
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 4 x float> poison, float %f, i32 0
  %splat = shufflevector <vscale x 4 x float> %ins, <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer
  %ext = call <2 x float> @llvm.vector.extract.v2f32.nxv4f32(<vscale x 4 x float> %splat, i64 0)
  ret <2 x float> %ext
}

define <2 x float> @extract_v2f32_nxv4f32_splat_const() {
; CHECK-LABEL: extract_v2f32_nxv4f32_splat_const:
; CHECK:       // %bb.0:
; CHECK-NEXT:    fmov v0.2s, #1.00000000
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 4 x float> poison, float 1.0, i32 0
  %splat = shufflevector <vscale x 4 x float> %ins, <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer
  %ext = call <2 x float> @llvm.vector.extract.v2f32.nxv4f32(<vscale x 4 x float> %splat, i64 0)
  ret <2 x float> %ext
}

define <4 x i32> @extract_v4i32_nxv8i32_splat_const() {
; CHECK-LABEL: extract_v4i32_nxv8i32_splat_const:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi v0.4s, #1
; CHECK-NEXT:    ret
  %ins = insertelement <vscale x 8 x i32> poison, i32 1, i32 0
  %splat = shufflevector <vscale x 8 x i32> %ins, <vscale x 8 x i32> poison, <vscale x 8 x i32> zeroinitializer
  %ext = call <4 x i32> @llvm.vector.extract.v4i32.nxv8i32(<vscale x 8 x i32> %splat, i64 0)
  ret <4 x i32> %ext
}

attributes #0 = { vscale_range(2,2) }
attributes #1 = { vscale_range(8,8) }

declare <2 x i64> @llvm.vector.extract.v2i64.nxv2i64(<vscale x 2 x i64>, i64)

declare <4 x i32> @llvm.vector.extract.v4i32.nxv4i32(<vscale x 4 x i32>, i64)
declare <4 x i32> @llvm.vector.extract.v4i32.nxv2i32(<vscale x 2 x i32>, i64)

declare <8 x i16> @llvm.vector.extract.v8i16.nxv8i16(<vscale x 8 x i16>, i64)
declare <8 x i16> @llvm.vector.extract.v8i16.nxv4i16(<vscale x 4 x i16>, i64)
declare <8 x i16> @llvm.vector.extract.v8i16.nxv2i16(<vscale x 2 x i16>, i64)

declare <16 x i8> @llvm.vector.extract.v16i8.nxv16i8(<vscale x 16 x i8>, i64)
declare <16 x i8> @llvm.vector.extract.v16i8.nxv8i8(<vscale x 8 x i8>, i64)
declare <16 x i8> @llvm.vector.extract.v16i8.nxv4i8(<vscale x 4 x i8>, i64)
declare <16 x i8> @llvm.vector.extract.v16i8.nxv2i8(<vscale x 2 x i8>, i64)

declare <2 x i1> @llvm.vector.extract.v2i1.nxv2i1(<vscale x 2 x i1>, i64)
declare <4 x i1> @llvm.vector.extract.v4i1.nxv4i1(<vscale x 4 x i1>, i64)
declare <8 x i1> @llvm.vector.extract.v8i1.nxv8i1(<vscale x 8 x i1>, i64)
declare <16 x i1> @llvm.vector.extract.v16i1.nxv16i1(<vscale x 16 x i1>, i64)

declare <4 x i64> @llvm.vector.extract.v4i64.nxv2i64(<vscale x 2 x i64>, i64)
declare <2 x float> @llvm.vector.extract.v2f32.nxv4f32(<vscale x 4 x float>, i64)
declare <4 x i32> @llvm.vector.extract.v4i32.nxv8i32(<vscale x 8 x i32>, i64)
