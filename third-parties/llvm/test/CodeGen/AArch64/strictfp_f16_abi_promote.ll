; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64-none-linux-gnu -mattr=-fp-armv8 < %s | FileCheck -check-prefix=NOFP16 %s

declare void @f16_user(half)
declare half @f16_result()

declare void @v2f16_user(<2 x half>)
declare <2 x half> @v2f16_result()

declare void @v4f16_user(<4 x half>)
declare <4 x half> @v4f16_result()

declare void @v8f16_user(<8 x half>)
declare <8 x half> @v8f16_result()

define void @f16_arg(half %arg, ptr %ptr) #0 {
; NOFP16-LABEL: f16_arg:
; NOFP16:       // %bb.0:
; NOFP16-NEXT:    stp x30, x19, [sp, #-16]! // 16-byte Folded Spill
; NOFP16-NEXT:    .cfi_def_cfa_offset 16
; NOFP16-NEXT:    .cfi_offset w19, -8
; NOFP16-NEXT:    .cfi_offset w30, -16
; NOFP16-NEXT:    and w0, w0, #0xffff
; NOFP16-NEXT:    mov x19, x1
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    str w0, [x19]
; NOFP16-NEXT:    ldp x30, x19, [sp], #16 // 16-byte Folded Reload
; NOFP16-NEXT:    ret
  %fpext = call float @llvm.experimental.constrained.fpext.f32.f16(half %arg, metadata !"fpexcept.strict")
  store float %fpext, ptr %ptr
  ret void
}

define void @v2f16_arg(<2 x half> %arg, ptr %ptr) #0 {
; NOFP16-LABEL: v2f16_arg:
; NOFP16:       // %bb.0:
; NOFP16-NEXT:    stp x30, x21, [sp, #-32]! // 16-byte Folded Spill
; NOFP16-NEXT:    stp x20, x19, [sp, #16] // 16-byte Folded Spill
; NOFP16-NEXT:    .cfi_def_cfa_offset 32
; NOFP16-NEXT:    .cfi_offset w19, -8
; NOFP16-NEXT:    .cfi_offset w20, -16
; NOFP16-NEXT:    .cfi_offset w21, -24
; NOFP16-NEXT:    .cfi_offset w30, -32
; NOFP16-NEXT:    and w0, w0, #0xffff
; NOFP16-NEXT:    mov x19, x2
; NOFP16-NEXT:    mov w20, w1
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w21, w0
; NOFP16-NEXT:    and w0, w20, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    stp w21, w0, [x19]
; NOFP16-NEXT:    ldp x20, x19, [sp, #16] // 16-byte Folded Reload
; NOFP16-NEXT:    ldp x30, x21, [sp], #32 // 16-byte Folded Reload
; NOFP16-NEXT:    ret
  %fpext = call <2 x float> @llvm.experimental.constrained.fpext.v2f32.v2f16(<2 x half> %arg, metadata !"fpexcept.strict")
  store <2 x float> %fpext, ptr %ptr
  ret void
}

define void @v3f16_arg(<3 x half> %arg, ptr %ptr) #0 {
; NOFP16-LABEL: v3f16_arg:
; NOFP16:       // %bb.0:
; NOFP16-NEXT:    str x30, [sp, #-48]! // 8-byte Folded Spill
; NOFP16-NEXT:    stp x22, x21, [sp, #16] // 16-byte Folded Spill
; NOFP16-NEXT:    stp x20, x19, [sp, #32] // 16-byte Folded Spill
; NOFP16-NEXT:    .cfi_def_cfa_offset 48
; NOFP16-NEXT:    .cfi_offset w19, -8
; NOFP16-NEXT:    .cfi_offset w20, -16
; NOFP16-NEXT:    .cfi_offset w21, -24
; NOFP16-NEXT:    .cfi_offset w22, -32
; NOFP16-NEXT:    .cfi_offset w30, -48
; NOFP16-NEXT:    mov w21, w0
; NOFP16-NEXT:    and w0, w2, #0xffff
; NOFP16-NEXT:    mov x19, x3
; NOFP16-NEXT:    mov w20, w1
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w22, w0
; NOFP16-NEXT:    and w0, w21, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w21, w0
; NOFP16-NEXT:    and w0, w20, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w8, w21
; NOFP16-NEXT:    // kill: def $w0 killed $w0 def $x0
; NOFP16-NEXT:    str w22, [x19, #8]
; NOFP16-NEXT:    orr x8, x8, x0, lsl #32
; NOFP16-NEXT:    ldp x22, x21, [sp, #16] // 16-byte Folded Reload
; NOFP16-NEXT:    str x8, [x19]
; NOFP16-NEXT:    ldp x20, x19, [sp, #32] // 16-byte Folded Reload
; NOFP16-NEXT:    ldr x30, [sp], #48 // 8-byte Folded Reload
; NOFP16-NEXT:    ret
  %fpext = call <3 x float> @llvm.experimental.constrained.fpext.v3f32.v3f16(<3 x half> %arg, metadata !"fpexcept.strict")
  store <3 x float> %fpext, ptr %ptr
  ret void
}

define void @v4f16_arg(<4 x half> %arg, ptr %ptr) #0 {
; NOFP16-LABEL: v4f16_arg:
; NOFP16:       // %bb.0:
; NOFP16-NEXT:    stp x30, x23, [sp, #-48]! // 16-byte Folded Spill
; NOFP16-NEXT:    stp x22, x21, [sp, #16] // 16-byte Folded Spill
; NOFP16-NEXT:    stp x20, x19, [sp, #32] // 16-byte Folded Spill
; NOFP16-NEXT:    .cfi_def_cfa_offset 48
; NOFP16-NEXT:    .cfi_offset w19, -8
; NOFP16-NEXT:    .cfi_offset w20, -16
; NOFP16-NEXT:    .cfi_offset w21, -24
; NOFP16-NEXT:    .cfi_offset w22, -32
; NOFP16-NEXT:    .cfi_offset w23, -40
; NOFP16-NEXT:    .cfi_offset w30, -48
; NOFP16-NEXT:    and w0, w0, #0xffff
; NOFP16-NEXT:    mov x19, x4
; NOFP16-NEXT:    mov w20, w3
; NOFP16-NEXT:    mov w21, w2
; NOFP16-NEXT:    mov w22, w1
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w23, w0
; NOFP16-NEXT:    and w0, w22, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w22, w0
; NOFP16-NEXT:    and w0, w21, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w21, w0
; NOFP16-NEXT:    and w0, w20, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    stp w21, w0, [x19, #8]
; NOFP16-NEXT:    stp w23, w22, [x19]
; NOFP16-NEXT:    ldp x20, x19, [sp, #32] // 16-byte Folded Reload
; NOFP16-NEXT:    ldp x22, x21, [sp, #16] // 16-byte Folded Reload
; NOFP16-NEXT:    ldp x30, x23, [sp], #48 // 16-byte Folded Reload
; NOFP16-NEXT:    ret
  %fpext = call <4 x float> @llvm.experimental.constrained.fpext.v4f32.v4f16(<4 x half> %arg, metadata !"fpexcept.strict")
  store <4 x float> %fpext, ptr %ptr
  ret void
}

; FIXME:
; define half @f16_return(float %arg) #0 {
;   %fptrunc = call half @llvm.experimental.constrained.fptrunc.f16.f32(float %arg, metadata !"round.tonearest", metadata !"fpexcept.strict")
;   ret half %fptrunc
; }

; define <2 x half> @v2f16_return(<2 x float> %arg) #0 {
;   %fptrunc = call <2 x half> @llvm.experimental.constrained.fptrunc.v2f16.v2f32(<2 x float> %arg, metadata !"round.tonearest", metadata !"fpexcept.strict")
;   ret <2 x half> %fptrunc
; }

; define <3 x half> @v3f16_return(<3 x float> %arg) #0 {
;   %fptrunc = call <3 x half> @llvm.experimental.constrained.fptrunc.v3f16.v3f32(<3 x float> %arg, metadata !"round.tonearest", metadata !"fpexcept.strict")
;   ret <3 x half> %fptrunc
; }

; define <4 x half> @v4f16_return(<4 x float> %arg) #0 {
;   %fptrunc = call <4 x half> @llvm.experimental.constrained.fptrunc.v4f16.v4f32(<4 x float> %arg, metadata !"round.tonearest", metadata !"fpexcept.strict")
;   ret <4 x half> %fptrunc
; }

; FIXME:
; define void @outgoing_f16_arg(ptr %ptr) #0 {
;   %val = load half, ptr %ptr
;   call void @f16_user(half %val)
;   ret void
; }

; define void @outgoing_v2f16_arg(ptr %ptr) #0 {
;   %val = load <2 x half>, ptr %ptr
;   call void @v2f16_user(<2 x half> %val)
;   ret void
; }

; define void @outgoing_f16_return(ptr %ptr) #0 {
;   %val = call half @f16_result()
;   store half %val, ptr %ptr
;   ret void
; }

; define void @outgoing_v2f16_return(ptr %ptr) #0 {
;   %val = call <2 x half> @v2f16_result()
;   store <2 x half> %val, ptr %ptr
;   ret void
; }

define void @outgoing_v4f16_return(ptr %ptr) #0 {
; NOFP16-LABEL: outgoing_v4f16_return:
; NOFP16:       // %bb.0:
; NOFP16-NEXT:    stp x30, x23, [sp, #-48]! // 16-byte Folded Spill
; NOFP16-NEXT:    stp x22, x21, [sp, #16] // 16-byte Folded Spill
; NOFP16-NEXT:    stp x20, x19, [sp, #32] // 16-byte Folded Spill
; NOFP16-NEXT:    .cfi_def_cfa_offset 48
; NOFP16-NEXT:    .cfi_offset w19, -8
; NOFP16-NEXT:    .cfi_offset w20, -16
; NOFP16-NEXT:    .cfi_offset w21, -24
; NOFP16-NEXT:    .cfi_offset w22, -32
; NOFP16-NEXT:    .cfi_offset w23, -40
; NOFP16-NEXT:    .cfi_offset w30, -48
; NOFP16-NEXT:    mov x19, x0
; NOFP16-NEXT:    bl v4f16_result
; NOFP16-NEXT:    and w0, w0, #0xffff
; NOFP16-NEXT:    mov w20, w1
; NOFP16-NEXT:    mov w21, w2
; NOFP16-NEXT:    mov w22, w3
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w23, w0
; NOFP16-NEXT:    and w0, w20, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w20, w0
; NOFP16-NEXT:    and w0, w21, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w21, w0
; NOFP16-NEXT:    and w0, w22, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19, #6]
; NOFP16-NEXT:    mov w0, w21
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19, #4]
; NOFP16-NEXT:    mov w0, w20
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19, #2]
; NOFP16-NEXT:    mov w0, w23
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19]
; NOFP16-NEXT:    ldp x20, x19, [sp, #32] // 16-byte Folded Reload
; NOFP16-NEXT:    ldp x22, x21, [sp, #16] // 16-byte Folded Reload
; NOFP16-NEXT:    ldp x30, x23, [sp], #48 // 16-byte Folded Reload
; NOFP16-NEXT:    ret
  %val = call <4 x half> @v4f16_result()
  store <4 x half> %val, ptr %ptr
  ret void
}

define void @outgoing_v8f16_return(ptr %ptr) #0 {
; NOFP16-LABEL: outgoing_v8f16_return:
; NOFP16:       // %bb.0:
; NOFP16-NEXT:    stp x30, x27, [sp, #-80]! // 16-byte Folded Spill
; NOFP16-NEXT:    stp x26, x25, [sp, #16] // 16-byte Folded Spill
; NOFP16-NEXT:    stp x24, x23, [sp, #32] // 16-byte Folded Spill
; NOFP16-NEXT:    stp x22, x21, [sp, #48] // 16-byte Folded Spill
; NOFP16-NEXT:    stp x20, x19, [sp, #64] // 16-byte Folded Spill
; NOFP16-NEXT:    .cfi_def_cfa_offset 80
; NOFP16-NEXT:    .cfi_offset w19, -8
; NOFP16-NEXT:    .cfi_offset w20, -16
; NOFP16-NEXT:    .cfi_offset w21, -24
; NOFP16-NEXT:    .cfi_offset w22, -32
; NOFP16-NEXT:    .cfi_offset w23, -40
; NOFP16-NEXT:    .cfi_offset w24, -48
; NOFP16-NEXT:    .cfi_offset w25, -56
; NOFP16-NEXT:    .cfi_offset w26, -64
; NOFP16-NEXT:    .cfi_offset w27, -72
; NOFP16-NEXT:    .cfi_offset w30, -80
; NOFP16-NEXT:    mov x19, x0
; NOFP16-NEXT:    bl v8f16_result
; NOFP16-NEXT:    and w0, w0, #0xffff
; NOFP16-NEXT:    mov w21, w1
; NOFP16-NEXT:    mov w22, w2
; NOFP16-NEXT:    mov w23, w3
; NOFP16-NEXT:    mov w24, w4
; NOFP16-NEXT:    mov w25, w5
; NOFP16-NEXT:    mov w26, w6
; NOFP16-NEXT:    mov w27, w7
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w20, w0
; NOFP16-NEXT:    and w0, w21, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w21, w0
; NOFP16-NEXT:    and w0, w22, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w22, w0
; NOFP16-NEXT:    and w0, w23, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w23, w0
; NOFP16-NEXT:    and w0, w24, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w24, w0
; NOFP16-NEXT:    and w0, w25, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w25, w0
; NOFP16-NEXT:    and w0, w26, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    mov w26, w0
; NOFP16-NEXT:    and w0, w27, #0xffff
; NOFP16-NEXT:    bl __gnu_h2f_ieee
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19, #14]
; NOFP16-NEXT:    mov w0, w26
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19, #12]
; NOFP16-NEXT:    mov w0, w25
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19, #10]
; NOFP16-NEXT:    mov w0, w24
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19, #8]
; NOFP16-NEXT:    mov w0, w23
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19, #6]
; NOFP16-NEXT:    mov w0, w22
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19, #4]
; NOFP16-NEXT:    mov w0, w21
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19, #2]
; NOFP16-NEXT:    mov w0, w20
; NOFP16-NEXT:    bl __gnu_f2h_ieee
; NOFP16-NEXT:    strh w0, [x19]
; NOFP16-NEXT:    ldp x20, x19, [sp, #64] // 16-byte Folded Reload
; NOFP16-NEXT:    ldp x22, x21, [sp, #48] // 16-byte Folded Reload
; NOFP16-NEXT:    ldp x24, x23, [sp, #32] // 16-byte Folded Reload
; NOFP16-NEXT:    ldp x26, x25, [sp, #16] // 16-byte Folded Reload
; NOFP16-NEXT:    ldp x30, x27, [sp], #80 // 16-byte Folded Reload
; NOFP16-NEXT:    ret
  %val = call <8 x half> @v8f16_result()
  store <8 x half> %val, ptr %ptr
  ret void
}

define half @call_split_type_used_outside_block_v8f16() #0 {
; NOFP16-LABEL: call_split_type_used_outside_block_v8f16:
; NOFP16:       // %bb.0: // %bb0
; NOFP16-NEXT:    str x30, [sp, #-16]! // 8-byte Folded Spill
; NOFP16-NEXT:    .cfi_def_cfa_offset 16
; NOFP16-NEXT:    .cfi_offset w30, -16
; NOFP16-NEXT:    bl v8f16_result
; NOFP16-NEXT:    ldr x30, [sp], #16 // 8-byte Folded Reload
; NOFP16-NEXT:    ret
bb0:
  %split.ret.type = call <8 x half> @v8f16_result()
  br label %bb1

bb1:
  %extract = extractelement <8 x half> %split.ret.type, i32 0
  ret half %extract
}

declare float @llvm.experimental.constrained.fpext.f32.f16(half, metadata) #0
declare <2 x float> @llvm.experimental.constrained.fpext.v2f32.v2f16(<2 x half>, metadata) #0
declare <3 x float> @llvm.experimental.constrained.fpext.v3f32.v3f16(<3 x half>, metadata) #0
declare <4 x float> @llvm.experimental.constrained.fpext.v4f32.v4f16(<4 x half>, metadata) #0

declare half @llvm.experimental.constrained.fptrunc.f16.f32(float, metadata, metadata) #0
declare <2 x half> @llvm.experimental.constrained.fptrunc.v2f16.v2f32(<2 x float>, metadata, metadata) #0
declare <3 x half> @llvm.experimental.constrained.fptrunc.v3f16.v3f32(<3 x float>, metadata, metadata) #0
declare <4 x half> @llvm.experimental.constrained.fptrunc.v4f16.v4f32(<4 x float>, metadata, metadata) #0

attributes #0 = { strictfp }
