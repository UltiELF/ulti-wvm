; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-none-linux-gnu -mattr=+neon | FileCheck %s --check-prefixes=CHECK,CHECK-NEON
; RUN: llc < %s -mtriple=aarch64-none-linux-gnu -mattr=-neon | FileCheck %s --check-prefixes=CHECK,CHECK-NO-NEON

declare i16 @llvm.umax.i16(i16, i16)
declare i64 @llvm.umin.i64(i64, i64)

declare <4 x float> @llvm.ldexp.v4f32.v4i32(<4 x float>, <4 x i32>)

define <4 x float> @fmul_pow2_4xfloat(<4 x i32> %i) {
; CHECK-NEON-LABEL: fmul_pow2_4xfloat:
; CHECK-NEON:       // %bb.0:
; CHECK-NEON-NEXT:    movi v1.4s, #1
; CHECK-NEON-NEXT:    ushl v0.4s, v1.4s, v0.4s
; CHECK-NEON-NEXT:    fmov v1.4s, #9.00000000
; CHECK-NEON-NEXT:    ucvtf v0.4s, v0.4s
; CHECK-NEON-NEXT:    fmul v0.4s, v0.4s, v1.4s
; CHECK-NEON-NEXT:    ret
;
; CHECK-NO-NEON-LABEL: fmul_pow2_4xfloat:
; CHECK-NO-NEON:       // %bb.0:
; CHECK-NO-NEON-NEXT:    mov w8, #1 // =0x1
; CHECK-NO-NEON-NEXT:    fmov s3, #9.00000000
; CHECK-NO-NEON-NEXT:    lsl w9, w8, w0
; CHECK-NO-NEON-NEXT:    lsl w10, w8, w1
; CHECK-NO-NEON-NEXT:    lsl w11, w8, w2
; CHECK-NO-NEON-NEXT:    lsl w8, w8, w3
; CHECK-NO-NEON-NEXT:    ucvtf s1, w10
; CHECK-NO-NEON-NEXT:    ucvtf s0, w9
; CHECK-NO-NEON-NEXT:    ucvtf s2, w11
; CHECK-NO-NEON-NEXT:    ucvtf s4, w8
; CHECK-NO-NEON-NEXT:    fmul s0, s0, s3
; CHECK-NO-NEON-NEXT:    fmul s1, s1, s3
; CHECK-NO-NEON-NEXT:    fmul s2, s2, s3
; CHECK-NO-NEON-NEXT:    fmul s3, s4, s3
; CHECK-NO-NEON-NEXT:    ret
  %p2 = shl <4 x i32> <i32 1, i32 1, i32 1, i32 1>, %i
  %p2_f = uitofp <4 x i32> %p2 to <4 x float>
  %r = fmul <4 x float> <float 9.000000e+00, float 9.000000e+00, float 9.000000e+00, float 9.000000e+00>, %p2_f
  ret <4 x float> %r
}

define <4 x float> @fmul_pow2_ldexp_4xfloat(<4 x i32> %i) {
; CHECK-NEON-LABEL: fmul_pow2_ldexp_4xfloat:
; CHECK-NEON:       // %bb.0:
; CHECK-NEON-NEXT:    sub sp, sp, #48
; CHECK-NEON-NEXT:    str x30, [sp, #32] // 8-byte Folded Spill
; CHECK-NEON-NEXT:    .cfi_def_cfa_offset 48
; CHECK-NEON-NEXT:    .cfi_offset w30, -16
; CHECK-NEON-NEXT:    mov w0, v0.s[1]
; CHECK-NEON-NEXT:    str q0, [sp, #16] // 16-byte Folded Spill
; CHECK-NEON-NEXT:    fmov s0, #9.00000000
; CHECK-NEON-NEXT:    bl ldexpf
; CHECK-NEON-NEXT:    ldr q1, [sp, #16] // 16-byte Folded Reload
; CHECK-NEON-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEON-NEXT:    str q0, [sp] // 16-byte Folded Spill
; CHECK-NEON-NEXT:    fmov s0, #9.00000000
; CHECK-NEON-NEXT:    fmov w0, s1
; CHECK-NEON-NEXT:    bl ldexpf
; CHECK-NEON-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; CHECK-NEON-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEON-NEXT:    mov v0.s[1], v1.s[0]
; CHECK-NEON-NEXT:    str q0, [sp] // 16-byte Folded Spill
; CHECK-NEON-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; CHECK-NEON-NEXT:    mov w0, v0.s[2]
; CHECK-NEON-NEXT:    fmov s0, #9.00000000
; CHECK-NEON-NEXT:    bl ldexpf
; CHECK-NEON-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; CHECK-NEON-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEON-NEXT:    mov v1.s[2], v0.s[0]
; CHECK-NEON-NEXT:    ldr q0, [sp, #16] // 16-byte Folded Reload
; CHECK-NEON-NEXT:    mov w0, v0.s[3]
; CHECK-NEON-NEXT:    fmov s0, #9.00000000
; CHECK-NEON-NEXT:    str q1, [sp] // 16-byte Folded Spill
; CHECK-NEON-NEXT:    bl ldexpf
; CHECK-NEON-NEXT:    ldr q1, [sp] // 16-byte Folded Reload
; CHECK-NEON-NEXT:    // kill: def $s0 killed $s0 def $q0
; CHECK-NEON-NEXT:    ldr x30, [sp, #32] // 8-byte Folded Reload
; CHECK-NEON-NEXT:    mov v1.s[3], v0.s[0]
; CHECK-NEON-NEXT:    mov v0.16b, v1.16b
; CHECK-NEON-NEXT:    add sp, sp, #48
; CHECK-NEON-NEXT:    ret
;
; CHECK-NO-NEON-LABEL: fmul_pow2_ldexp_4xfloat:
; CHECK-NO-NEON:       // %bb.0:
; CHECK-NO-NEON-NEXT:    str d10, [sp, #-64]! // 8-byte Folded Spill
; CHECK-NO-NEON-NEXT:    stp d9, d8, [sp, #16] // 16-byte Folded Spill
; CHECK-NO-NEON-NEXT:    stp x30, x21, [sp, #32] // 16-byte Folded Spill
; CHECK-NO-NEON-NEXT:    stp x20, x19, [sp, #48] // 16-byte Folded Spill
; CHECK-NO-NEON-NEXT:    .cfi_def_cfa_offset 64
; CHECK-NO-NEON-NEXT:    .cfi_offset w19, -8
; CHECK-NO-NEON-NEXT:    .cfi_offset w20, -16
; CHECK-NO-NEON-NEXT:    .cfi_offset w21, -24
; CHECK-NO-NEON-NEXT:    .cfi_offset w30, -32
; CHECK-NO-NEON-NEXT:    .cfi_offset b8, -40
; CHECK-NO-NEON-NEXT:    .cfi_offset b9, -48
; CHECK-NO-NEON-NEXT:    .cfi_offset b10, -64
; CHECK-NO-NEON-NEXT:    fmov s0, #9.00000000
; CHECK-NO-NEON-NEXT:    mov w19, w3
; CHECK-NO-NEON-NEXT:    mov w20, w2
; CHECK-NO-NEON-NEXT:    mov w21, w1
; CHECK-NO-NEON-NEXT:    bl ldexpf
; CHECK-NO-NEON-NEXT:    fmov s8, s0
; CHECK-NO-NEON-NEXT:    fmov s0, #9.00000000
; CHECK-NO-NEON-NEXT:    mov w0, w21
; CHECK-NO-NEON-NEXT:    bl ldexpf
; CHECK-NO-NEON-NEXT:    fmov s9, s0
; CHECK-NO-NEON-NEXT:    fmov s0, #9.00000000
; CHECK-NO-NEON-NEXT:    mov w0, w20
; CHECK-NO-NEON-NEXT:    bl ldexpf
; CHECK-NO-NEON-NEXT:    fmov s10, s0
; CHECK-NO-NEON-NEXT:    fmov s0, #9.00000000
; CHECK-NO-NEON-NEXT:    mov w0, w19
; CHECK-NO-NEON-NEXT:    bl ldexpf
; CHECK-NO-NEON-NEXT:    fmov s3, s0
; CHECK-NO-NEON-NEXT:    fmov s0, s8
; CHECK-NO-NEON-NEXT:    fmov s1, s9
; CHECK-NO-NEON-NEXT:    ldp x20, x19, [sp, #48] // 16-byte Folded Reload
; CHECK-NO-NEON-NEXT:    fmov s2, s10
; CHECK-NO-NEON-NEXT:    ldp x30, x21, [sp, #32] // 16-byte Folded Reload
; CHECK-NO-NEON-NEXT:    ldp d9, d8, [sp, #16] // 16-byte Folded Reload
; CHECK-NO-NEON-NEXT:    ldr d10, [sp], #64 // 8-byte Folded Reload
; CHECK-NO-NEON-NEXT:    ret
  %r = call <4 x float> @llvm.ldexp.v4f32.v4i32(<4 x float> <float 9.000000e+00, float 9.000000e+00, float 9.000000e+00, float 9.000000e+00>, <4 x i32> %i)
  ret <4 x float> %r
}

define <4 x float> @fdiv_pow2_4xfloat(<4 x i32> %i) {
; CHECK-NEON-LABEL: fdiv_pow2_4xfloat:
; CHECK-NEON:       // %bb.0:
; CHECK-NEON-NEXT:    fmov v1.4s, #9.00000000
; CHECK-NEON-NEXT:    shl v0.4s, v0.4s, #23
; CHECK-NEON-NEXT:    sub v0.4s, v1.4s, v0.4s
; CHECK-NEON-NEXT:    ret
;
; CHECK-NO-NEON-LABEL: fdiv_pow2_4xfloat:
; CHECK-NO-NEON:       // %bb.0:
; CHECK-NO-NEON-NEXT:    mov w8, #1091567616 // =0x41100000
; CHECK-NO-NEON-NEXT:    sub w9, w8, w0, lsl #23
; CHECK-NO-NEON-NEXT:    sub w10, w8, w1, lsl #23
; CHECK-NO-NEON-NEXT:    sub w11, w8, w2, lsl #23
; CHECK-NO-NEON-NEXT:    sub w8, w8, w3, lsl #23
; CHECK-NO-NEON-NEXT:    fmov s0, w9
; CHECK-NO-NEON-NEXT:    fmov s1, w10
; CHECK-NO-NEON-NEXT:    fmov s2, w11
; CHECK-NO-NEON-NEXT:    fmov s3, w8
; CHECK-NO-NEON-NEXT:    ret
  %p2 = shl <4 x i32> <i32 1, i32 1, i32 1, i32 1>, %i
  %p2_f = uitofp <4 x i32> %p2 to <4 x float>
  %r = fdiv <4 x float> <float 9.000000e+00, float 9.000000e+00, float 9.000000e+00, float 9.000000e+00>, %p2_f
  ret <4 x float> %r
}

define double @fmul_pow_shl_cnt(i64 %cnt) nounwind {
; CHECK-LABEL: fmul_pow_shl_cnt:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    fmov d1, #9.00000000
; CHECK-NEXT:    lsl x8, x8, x0
; CHECK-NEXT:    ucvtf d0, x8
; CHECK-NEXT:    fmul d0, d0, d1
; CHECK-NEXT:    ret
  %shl = shl nuw i64 1, %cnt
  %conv = uitofp i64 %shl to double
  %mul = fmul double 9.000000e+00, %conv
  ret double %mul
}

define double @fmul_pow_shl_cnt2(i64 %cnt) nounwind {
; CHECK-LABEL: fmul_pow_shl_cnt2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #2 // =0x2
; CHECK-NEXT:    fmov d1, #-9.00000000
; CHECK-NEXT:    lsl x8, x8, x0
; CHECK-NEXT:    ucvtf d0, x8
; CHECK-NEXT:    fmul d0, d0, d1
; CHECK-NEXT:    ret
  %shl = shl nuw i64 2, %cnt
  %conv = uitofp i64 %shl to double
  %mul = fmul double -9.000000e+00, %conv
  ret double %mul
}

define float @fmul_pow_select(i32 %cnt, i1 %c) nounwind {
; CHECK-LABEL: fmul_pow_select:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    tst w1, #0x1
; CHECK-NEXT:    fmov s1, #9.00000000
; CHECK-NEXT:    cinc w8, w8, eq
; CHECK-NEXT:    lsl w8, w8, w0
; CHECK-NEXT:    ucvtf s0, w8
; CHECK-NEXT:    fmul s0, s0, s1
; CHECK-NEXT:    ret
  %shl2 = shl nuw i32 2, %cnt
  %shl1 = shl nuw i32 1, %cnt
  %shl = select i1 %c, i32 %shl1, i32 %shl2
  %conv = uitofp i32 %shl to float
  %mul = fmul float 9.000000e+00, %conv
  ret float %mul
}

define float @fmul_fly_pow_mul_min_pow2(i64 %cnt) nounwind {
; CHECK-LABEL: fmul_fly_pow_mul_min_pow2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #8 // =0x8
; CHECK-NEXT:    mov w9, #8192 // =0x2000
; CHECK-NEXT:    fmov s1, #9.00000000
; CHECK-NEXT:    lsl x8, x8, x0
; CHECK-NEXT:    cmp x8, #2, lsl #12 // =8192
; CHECK-NEXT:    csel x8, x8, x9, lo
; CHECK-NEXT:    ucvtf s0, x8
; CHECK-NEXT:    fmul s0, s0, s1
; CHECK-NEXT:    ret
  %shl8 = shl nuw i64 8, %cnt
  %shl = call i64 @llvm.umin.i64(i64 %shl8, i64 8192)
  %conv = uitofp i64 %shl to float
  %mul = fmul float 9.000000e+00, %conv
  ret float %mul
}

define double @fmul_pow_mul_max_pow2(i16 %cnt) nounwind {
; CHECK-LABEL: fmul_pow_mul_max_pow2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #2 // =0x2
; CHECK-NEXT:    mov w9, #1 // =0x1
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    fmov d1, #3.00000000
; CHECK-NEXT:    lsl w8, w8, w0
; CHECK-NEXT:    lsl w9, w9, w0
; CHECK-NEXT:    and w8, w8, #0xfffe
; CHECK-NEXT:    and w9, w9, #0xffff
; CHECK-NEXT:    cmp w9, w8
; CHECK-NEXT:    csel w8, w9, w8, hi
; CHECK-NEXT:    ucvtf d0, w8
; CHECK-NEXT:    fmul d0, d0, d1
; CHECK-NEXT:    ret
  %shl2 = shl nuw i16 2, %cnt
  %shl1 = shl nuw i16 1, %cnt
  %shl = call i16 @llvm.umax.i16(i16 %shl1, i16 %shl2)
  %conv = uitofp i16 %shl to double
  %mul = fmul double 3.000000e+00, %conv
  ret double %mul
}

define double @fmul_pow_shl_cnt_fail_maybe_non_pow2(i64 %v, i64 %cnt) nounwind {
; CHECK-LABEL: fmul_pow_shl_cnt_fail_maybe_non_pow2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    lsl x8, x0, x1
; CHECK-NEXT:    fmov d1, #9.00000000
; CHECK-NEXT:    ucvtf d0, x8
; CHECK-NEXT:    fmul d0, d0, d1
; CHECK-NEXT:    ret
  %shl = shl nuw i64 %v, %cnt
  %conv = uitofp i64 %shl to double
  %mul = fmul double 9.000000e+00, %conv
  ret double %mul
}

define <2 x float> @fmul_pow_shl_cnt_vec_fail_expensive_cast(<2 x i64> %cnt) nounwind {
; CHECK-NEON-LABEL: fmul_pow_shl_cnt_vec_fail_expensive_cast:
; CHECK-NEON:       // %bb.0:
; CHECK-NEON-NEXT:    mov w8, #2 // =0x2
; CHECK-NEON-NEXT:    dup v1.2d, x8
; CHECK-NEON-NEXT:    ushl v0.2d, v1.2d, v0.2d
; CHECK-NEON-NEXT:    fmov v1.2s, #15.00000000
; CHECK-NEON-NEXT:    ucvtf v0.2d, v0.2d
; CHECK-NEON-NEXT:    fcvtn v0.2s, v0.2d
; CHECK-NEON-NEXT:    fmul v0.2s, v0.2s, v1.2s
; CHECK-NEON-NEXT:    ret
;
; CHECK-NO-NEON-LABEL: fmul_pow_shl_cnt_vec_fail_expensive_cast:
; CHECK-NO-NEON:       // %bb.0:
; CHECK-NO-NEON-NEXT:    mov w8, #2 // =0x2
; CHECK-NO-NEON-NEXT:    fmov s2, #15.00000000
; CHECK-NO-NEON-NEXT:    lsl x9, x8, x0
; CHECK-NO-NEON-NEXT:    lsl x8, x8, x1
; CHECK-NO-NEON-NEXT:    ucvtf s1, x8
; CHECK-NO-NEON-NEXT:    ucvtf s0, x9
; CHECK-NO-NEON-NEXT:    fmul s0, s0, s2
; CHECK-NO-NEON-NEXT:    fmul s1, s1, s2
; CHECK-NO-NEON-NEXT:    ret
  %shl = shl nsw nuw <2 x i64> <i64 2, i64 2>, %cnt
  %conv = uitofp <2 x i64> %shl to <2 x float>
  %mul = fmul <2 x float> <float 15.000000e+00, float 15.000000e+00>, %conv
  ret <2 x float> %mul
}

define <2 x double> @fmul_pow_shl_cnt_vec(<2 x i64> %cnt) nounwind {
; CHECK-NEON-LABEL: fmul_pow_shl_cnt_vec:
; CHECK-NEON:       // %bb.0:
; CHECK-NEON-NEXT:    mov w8, #2 // =0x2
; CHECK-NEON-NEXT:    dup v1.2d, x8
; CHECK-NEON-NEXT:    ushl v0.2d, v1.2d, v0.2d
; CHECK-NEON-NEXT:    fmov v1.2d, #15.00000000
; CHECK-NEON-NEXT:    ucvtf v0.2d, v0.2d
; CHECK-NEON-NEXT:    fmul v0.2d, v0.2d, v1.2d
; CHECK-NEON-NEXT:    ret
;
; CHECK-NO-NEON-LABEL: fmul_pow_shl_cnt_vec:
; CHECK-NO-NEON:       // %bb.0:
; CHECK-NO-NEON-NEXT:    mov w8, #2 // =0x2
; CHECK-NO-NEON-NEXT:    fmov d2, #15.00000000
; CHECK-NO-NEON-NEXT:    lsl x9, x8, x0
; CHECK-NO-NEON-NEXT:    lsl x8, x8, x1
; CHECK-NO-NEON-NEXT:    ucvtf d1, x8
; CHECK-NO-NEON-NEXT:    ucvtf d0, x9
; CHECK-NO-NEON-NEXT:    fmul d0, d0, d2
; CHECK-NO-NEON-NEXT:    fmul d1, d1, d2
; CHECK-NO-NEON-NEXT:    ret
  %shl = shl nsw nuw <2 x i64> <i64 2, i64 2>, %cnt
  %conv = uitofp <2 x i64> %shl to <2 x double>
  %mul = fmul <2 x double> <double 15.000000e+00, double 15.000000e+00>, %conv
  ret <2 x double> %mul
}

define <4 x float> @fmul_pow_shl_cnt_vec_preserve_fma(<4 x i32> %cnt, <4 x float> %add) nounwind {
; CHECK-NEON-LABEL: fmul_pow_shl_cnt_vec_preserve_fma:
; CHECK-NEON:       // %bb.0:
; CHECK-NEON-NEXT:    movi v2.4s, #2
; CHECK-NEON-NEXT:    ushl v0.4s, v2.4s, v0.4s
; CHECK-NEON-NEXT:    fmov v2.4s, #5.00000000
; CHECK-NEON-NEXT:    ucvtf v0.4s, v0.4s
; CHECK-NEON-NEXT:    fmul v0.4s, v0.4s, v2.4s
; CHECK-NEON-NEXT:    fadd v0.4s, v0.4s, v1.4s
; CHECK-NEON-NEXT:    ret
;
; CHECK-NO-NEON-LABEL: fmul_pow_shl_cnt_vec_preserve_fma:
; CHECK-NO-NEON:       // %bb.0:
; CHECK-NO-NEON-NEXT:    mov w8, #2 // =0x2
; CHECK-NO-NEON-NEXT:    fmov s16, #5.00000000
; CHECK-NO-NEON-NEXT:    lsl w9, w8, w3
; CHECK-NO-NEON-NEXT:    lsl w10, w8, w0
; CHECK-NO-NEON-NEXT:    lsl w11, w8, w2
; CHECK-NO-NEON-NEXT:    lsl w8, w8, w1
; CHECK-NO-NEON-NEXT:    ucvtf s4, w10
; CHECK-NO-NEON-NEXT:    ucvtf s5, w9
; CHECK-NO-NEON-NEXT:    ucvtf s7, w11
; CHECK-NO-NEON-NEXT:    ucvtf s6, w8
; CHECK-NO-NEON-NEXT:    fmul s5, s5, s16
; CHECK-NO-NEON-NEXT:    fmul s4, s4, s16
; CHECK-NO-NEON-NEXT:    fmul s7, s7, s16
; CHECK-NO-NEON-NEXT:    fmul s6, s6, s16
; CHECK-NO-NEON-NEXT:    fadd s0, s4, s0
; CHECK-NO-NEON-NEXT:    fadd s3, s5, s3
; CHECK-NO-NEON-NEXT:    fadd s1, s6, s1
; CHECK-NO-NEON-NEXT:    fadd s2, s7, s2
; CHECK-NO-NEON-NEXT:    ret
  %shl = shl nsw nuw <4 x i32> <i32 2, i32 2, i32 2, i32 2>, %cnt
  %conv = uitofp <4 x i32> %shl to <4 x float>
  %mul = fmul <4 x float> <float 5.000000e+00, float 5.000000e+00, float 5.000000e+00, float 5.000000e+00>, %conv
  %res = fadd <4 x float> %mul, %add
  ret <4 x float> %res
}

define <2 x double> @fmul_pow_shl_cnt_vec_non_splat_todo(<2 x i64> %cnt) nounwind {
; CHECK-NEON-LABEL: fmul_pow_shl_cnt_vec_non_splat_todo:
; CHECK-NEON:       // %bb.0:
; CHECK-NEON-NEXT:    mov w8, #2 // =0x2
; CHECK-NEON-NEXT:    dup v1.2d, x8
; CHECK-NEON-NEXT:    adrp x8, .LCPI12_0
; CHECK-NEON-NEXT:    ushl v0.2d, v1.2d, v0.2d
; CHECK-NEON-NEXT:    ldr q1, [x8, :lo12:.LCPI12_0]
; CHECK-NEON-NEXT:    ucvtf v0.2d, v0.2d
; CHECK-NEON-NEXT:    fmul v0.2d, v0.2d, v1.2d
; CHECK-NEON-NEXT:    ret
;
; CHECK-NO-NEON-LABEL: fmul_pow_shl_cnt_vec_non_splat_todo:
; CHECK-NO-NEON:       // %bb.0:
; CHECK-NO-NEON-NEXT:    mov w8, #2 // =0x2
; CHECK-NO-NEON-NEXT:    fmov d2, #15.00000000
; CHECK-NO-NEON-NEXT:    fmov d3, #14.00000000
; CHECK-NO-NEON-NEXT:    lsl x9, x8, x0
; CHECK-NO-NEON-NEXT:    lsl x8, x8, x1
; CHECK-NO-NEON-NEXT:    ucvtf d1, x8
; CHECK-NO-NEON-NEXT:    ucvtf d0, x9
; CHECK-NO-NEON-NEXT:    fmul d0, d0, d2
; CHECK-NO-NEON-NEXT:    fmul d1, d1, d3
; CHECK-NO-NEON-NEXT:    ret
  %shl = shl nsw nuw <2 x i64> <i64 2, i64 2>, %cnt
  %conv = uitofp <2 x i64> %shl to <2 x double>
  %mul = fmul <2 x double> <double 15.000000e+00, double 14.000000e+00>, %conv
  ret <2 x double> %mul
}

define <2 x double> @fmul_pow_shl_cnt_vec_non_splat2_todo(<2 x i64> %cnt) nounwind {
; CHECK-NEON-LABEL: fmul_pow_shl_cnt_vec_non_splat2_todo:
; CHECK-NEON:       // %bb.0:
; CHECK-NEON-NEXT:    adrp x8, .LCPI13_0
; CHECK-NEON-NEXT:    ldr q1, [x8, :lo12:.LCPI13_0]
; CHECK-NEON-NEXT:    ushl v0.2d, v1.2d, v0.2d
; CHECK-NEON-NEXT:    fmov v1.2d, #15.00000000
; CHECK-NEON-NEXT:    ucvtf v0.2d, v0.2d
; CHECK-NEON-NEXT:    fmul v0.2d, v0.2d, v1.2d
; CHECK-NEON-NEXT:    ret
;
; CHECK-NO-NEON-LABEL: fmul_pow_shl_cnt_vec_non_splat2_todo:
; CHECK-NO-NEON:       // %bb.0:
; CHECK-NO-NEON-NEXT:    mov w8, #2 // =0x2
; CHECK-NO-NEON-NEXT:    mov w9, #1 // =0x1
; CHECK-NO-NEON-NEXT:    fmov d2, #15.00000000
; CHECK-NO-NEON-NEXT:    lsl x8, x8, x0
; CHECK-NO-NEON-NEXT:    lsl x9, x9, x1
; CHECK-NO-NEON-NEXT:    ucvtf d1, x9
; CHECK-NO-NEON-NEXT:    ucvtf d0, x8
; CHECK-NO-NEON-NEXT:    fmul d0, d0, d2
; CHECK-NO-NEON-NEXT:    fmul d1, d1, d2
; CHECK-NO-NEON-NEXT:    ret
  %shl = shl nsw nuw <2 x i64> <i64 2, i64 1>, %cnt
  %conv = uitofp <2 x i64> %shl to <2 x double>
  %mul = fmul <2 x double> <double 15.000000e+00, double 15.000000e+00>, %conv
  ret <2 x double> %mul
}


define double @fmul_pow_shl_cnt_fail_maybe_bad_exp(i64 %cnt) nounwind {
; CHECK-LABEL: fmul_pow_shl_cnt_fail_maybe_bad_exp:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    lsl x8, x8, x0
; CHECK-NEXT:    ucvtf d0, x8
; CHECK-NEXT:    adrp x8, .LCPI14_0
; CHECK-NEXT:    ldr d1, [x8, :lo12:.LCPI14_0]
; CHECK-NEXT:    fmul d0, d0, d1
; CHECK-NEXT:    ret
  %shl = shl nuw i64 1, %cnt
  %conv = uitofp i64 %shl to double
  %mul = fmul double 9.745314e+288, %conv
  ret double %mul
}

define double @fmul_pow_shl_cnt_safe(i16 %cnt) nounwind {
; CHECK-LABEL: fmul_pow_shl_cnt_safe:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    lsl w8, w8, w0
; CHECK-NEXT:    and w8, w8, #0xffff
; CHECK-NEXT:    ucvtf d0, w8
; CHECK-NEXT:    adrp x8, .LCPI15_0
; CHECK-NEXT:    ldr d1, [x8, :lo12:.LCPI15_0]
; CHECK-NEXT:    fmul d0, d0, d1
; CHECK-NEXT:    ret
  %shl = shl nuw i16 1, %cnt
  %conv = uitofp i16 %shl to double
  %mul = fmul double 9.745314e+288, %conv
  ret double %mul
}

define <2 x double> @fdiv_pow_shl_cnt_vec(<2 x i64> %cnt) nounwind {
; CHECK-NEON-LABEL: fdiv_pow_shl_cnt_vec:
; CHECK-NEON:       // %bb.0:
; CHECK-NEON-NEXT:    fmov v1.2d, #1.00000000
; CHECK-NEON-NEXT:    shl v0.2d, v0.2d, #52
; CHECK-NEON-NEXT:    sub v0.2d, v1.2d, v0.2d
; CHECK-NEON-NEXT:    ret
;
; CHECK-NO-NEON-LABEL: fdiv_pow_shl_cnt_vec:
; CHECK-NO-NEON:       // %bb.0:
; CHECK-NO-NEON-NEXT:    mov x8, #4607182418800017408 // =0x3ff0000000000000
; CHECK-NO-NEON-NEXT:    sub x9, x8, x0, lsl #52
; CHECK-NO-NEON-NEXT:    sub x8, x8, x1, lsl #52
; CHECK-NO-NEON-NEXT:    fmov d0, x9
; CHECK-NO-NEON-NEXT:    fmov d1, x8
; CHECK-NO-NEON-NEXT:    ret
  %shl = shl nuw <2 x i64> <i64 1, i64 1>, %cnt
  %conv = uitofp <2 x i64> %shl to <2 x double>
  %mul = fdiv <2 x double> <double 1.000000e+00, double 1.000000e+00>, %conv
  ret <2 x double> %mul
}

define <2 x float> @fdiv_pow_shl_cnt_vec_with_expensive_cast(<2 x i64> %cnt) nounwind {
; CHECK-NEON-LABEL: fdiv_pow_shl_cnt_vec_with_expensive_cast:
; CHECK-NEON:       // %bb.0:
; CHECK-NEON-NEXT:    xtn v0.2s, v0.2d
; CHECK-NEON-NEXT:    fmov v1.2s, #1.00000000
; CHECK-NEON-NEXT:    shl v0.2s, v0.2s, #23
; CHECK-NEON-NEXT:    sub v0.2s, v1.2s, v0.2s
; CHECK-NEON-NEXT:    ret
;
; CHECK-NO-NEON-LABEL: fdiv_pow_shl_cnt_vec_with_expensive_cast:
; CHECK-NO-NEON:       // %bb.0:
; CHECK-NO-NEON-NEXT:    mov w8, #1065353216 // =0x3f800000
; CHECK-NO-NEON-NEXT:    sub w9, w8, w0, lsl #23
; CHECK-NO-NEON-NEXT:    sub w8, w8, w1, lsl #23
; CHECK-NO-NEON-NEXT:    fmov s0, w9
; CHECK-NO-NEON-NEXT:    fmov s1, w8
; CHECK-NO-NEON-NEXT:    ret
  %shl = shl nuw <2 x i64> <i64 1, i64 1>, %cnt
  %conv = uitofp <2 x i64> %shl to <2 x float>
  %mul = fdiv <2 x float> <float 1.000000e+00, float 1.000000e+00>, %conv
  ret <2 x float> %mul
}

define float @fdiv_pow_shl_cnt_fail_maybe_z(i64 %cnt) nounwind {
; CHECK-LABEL: fdiv_pow_shl_cnt_fail_maybe_z:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #8 // =0x8
; CHECK-NEXT:    fmov s1, #-9.00000000
; CHECK-NEXT:    lsl x8, x8, x0
; CHECK-NEXT:    ucvtf s0, x8
; CHECK-NEXT:    fdiv s0, s1, s0
; CHECK-NEXT:    ret
  %shl = shl i64 8, %cnt
  %conv = uitofp i64 %shl to float
  %mul = fdiv float -9.000000e+00, %conv
  ret float %mul
}

define float @fdiv_pow_shl_cnt_fail_neg_int(i64 %cnt) nounwind {
; CHECK-LABEL: fdiv_pow_shl_cnt_fail_neg_int:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #8 // =0x8
; CHECK-NEXT:    fmov s1, #-9.00000000
; CHECK-NEXT:    lsl x8, x8, x0
; CHECK-NEXT:    scvtf s0, x8
; CHECK-NEXT:    fdiv s0, s1, s0
; CHECK-NEXT:    ret
  %shl = shl i64 8, %cnt
  %conv = sitofp i64 %shl to float
  %mul = fdiv float -9.000000e+00, %conv
  ret float %mul
}

define float @fdiv_pow_shl_cnt(i64 %cnt_in) nounwind {
; CHECK-LABEL: fdiv_pow_shl_cnt:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #8 // =0x8
; CHECK-NEXT:    and x9, x0, #0x1f
; CHECK-NEXT:    fmov s1, #-0.50000000
; CHECK-NEXT:    lsl x8, x8, x9
; CHECK-NEXT:    scvtf s0, x8
; CHECK-NEXT:    fdiv s0, s1, s0
; CHECK-NEXT:    ret
  %cnt = and i64 %cnt_in, 31
  %shl = shl i64 8, %cnt
  %conv = sitofp i64 %shl to float
  %mul = fdiv float -0.500000e+00, %conv
  ret float %mul
}

define double @fdiv_pow_shl_cnt32_to_dbl_okay(i32 %cnt) nounwind {
; CHECK-LABEL: fdiv_pow_shl_cnt32_to_dbl_okay:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #3936146074321813504 // =0x36a0000000000000
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sub x8, x8, x0, lsl #52
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    ret
  %shl = shl nuw i32 1, %cnt
  %conv = uitofp i32 %shl to double
  %mul = fdiv double 0x36A0000000000000, %conv
  ret double %mul
}

define float @fdiv_pow_shl_cnt32_out_of_bounds2(i32 %cnt) nounwind {
; CHECK-LABEL: fdiv_pow_shl_cnt32_out_of_bounds2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #1 // =0x1
; CHECK-NEXT:    lsl w8, w8, w0
; CHECK-NEXT:    ucvtf s0, w8
; CHECK-NEXT:    mov w8, #65528 // =0xfff8
; CHECK-NEXT:    movk w8, #4351, lsl #16
; CHECK-NEXT:    fmov s1, w8
; CHECK-NEXT:    fdiv s0, s1, s0
; CHECK-NEXT:    ret
  %shl = shl nuw i32 1, %cnt
  %conv = uitofp i32 %shl to float
  %mul = fdiv float 0x3a1fffff00000000, %conv
  ret float %mul
}

define float @fdiv_pow_shl_cnt32_okay(i32 %cnt) nounwind {
; CHECK-LABEL: fdiv_pow_shl_cnt32_okay:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #285212672 // =0x11000000
; CHECK-NEXT:    sub w8, w8, w0, lsl #23
; CHECK-NEXT:    fmov s0, w8
; CHECK-NEXT:    ret
  %shl = shl nuw i32 1, %cnt
  %conv = uitofp i32 %shl to float
  %mul = fdiv float 0x3a20000000000000, %conv
  ret float %mul
}

define fastcc i1 @quantum_hadamard(i32 %0) {
; CHECK-LABEL: quantum_hadamard:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov x8, #4607182418800017408 // =0x3ff0000000000000
; CHECK-NEXT:    // kill: def $w0 killed $w0 def $x0
; CHECK-NEXT:    sub x8, x8, x0, lsl #52
; CHECK-NEXT:    fmov d0, x8
; CHECK-NEXT:    fcvt s0, d0
; CHECK-NEXT:    fcmp s0, #0.0
; CHECK-NEXT:    cset w0, gt
; CHECK-NEXT:    ret
  %2 = zext i32 %0 to i64
  %3 = shl i64 1, %2
  %4 = uitofp i64 %3 to double
  %5 = fdiv double 1.000000e+00, %4
  %6 = fptrunc double %5 to float
  %7 = fcmp olt float 0.000000e+00, %6
  ret i1 %7
}

define <vscale x 4 x float> @fdiv_pow2_nx4xfloat(<vscale x 4 x i32> %i) "target-features"="+sve" {
; CHECK-LABEL: fdiv_pow2_nx4xfloat:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.s
; CHECK-NEXT:    mov z1.s, #1 // =0x1
; CHECK-NEXT:    lslr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    fmov z1.s, #9.00000000
; CHECK-NEXT:    ucvtf z0.s, p0/m, z0.s
; CHECK-NEXT:    fdivr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT:    ret
  %p2 = shl <vscale x 4 x i32> shufflevector (<vscale x 4 x i32> insertelement (<vscale x 4 x i32> poison, i32 1, i64 0), <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer), %i
  %p2_f = uitofp <vscale x 4 x i32> %p2 to <vscale x 4 x float>
  %r = fdiv <vscale x 4 x float> shufflevector (<vscale x 4 x float> insertelement (<vscale x 4 x float> poison, float 9.000000e+00, i64 0), <vscale x 4 x float> poison, <vscale x 4 x i32> zeroinitializer), %p2_f
  ret <vscale x 4 x float> %r
}

define <vscale x 2 x double> @scalable2(<vscale x 2 x i64> %0) "target-features"="+sve" {
; CHECK-LABEL: scalable2:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ptrue p0.d
; CHECK-NEXT:    fmov z1.d, #1.00000000
; CHECK-NEXT:    ucvtf z0.d, p0/m, z0.d
; CHECK-NEXT:    fdivr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT:    ret
  %2 = uitofp <vscale x 2 x i64> %0 to <vscale x 2 x double>
  %3 = fdiv <vscale x 2 x double> shufflevector (<vscale x 2 x double> insertelement (<vscale x 2 x double> poison, double 1.000000e+00, i64 0), <vscale x 2 x double> poison, <vscale x 2 x i32> zeroinitializer), %2
  ret <vscale x 2 x double> %3
}
