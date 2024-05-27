; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu -mattr=+avx512f,+avx512vl,+avx512bw,+avx512bf16 | FileCheck %s

target triple = "x86_64-unknown-linux-gnu"

define <2 x bfloat> @shuffle_chained_v32bf16_v2bf16(<32 x bfloat> %a) {
; CHECK-LABEL: shuffle_chained_v32bf16_v2bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movq %rsp, %rbp
; CHECK-NEXT:    .cfi_def_cfa_register %rbp
; CHECK-NEXT:    andq $-64, %rsp
; CHECK-NEXT:    subq $128, %rsp
; CHECK-NEXT:    vpbroadcastd {{.*#+}} xmm1 = [0,16,0,16,0,16,0,16]
; CHECK-NEXT:    vpermw %zmm0, %zmm1, %zmm0
; CHECK-NEXT:    vmovdqa64 %zmm0, (%rsp)
; CHECK-NEXT:    vmovaps (%rsp), %xmm0
; CHECK-NEXT:    movq %rbp, %rsp
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa %rsp, 8
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %s = shufflevector <32 x bfloat> %a, <32 x bfloat> zeroinitializer, <32 x i32> <i32 0, i32 16, i32 1, i32 17, i32 2, i32 18, i32 3, i32 19, i32 4, i32 20, i32 5, i32 21, i32 6, i32 22, i32 7, i32 23, i32 8, i32 24, i32 9, i32 25, i32 10, i32 26, i32 11, i32 27, i32 12, i32 28, i32 13, i32 29, i32 14, i32 30, i32 15, i32 31>
  %s2 = shufflevector <32 x bfloat> %s, <32 x bfloat> zeroinitializer, <2 x i32> <i32 0, i32 1>
  ret <2 x bfloat> %s2
}

define <2 x bfloat> @shuffle_chained_v16bf16(<16 x bfloat> %a) {
; CHECK-LABEL: shuffle_chained_v16bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbp
; CHECK-NEXT:    .cfi_def_cfa_offset 16
; CHECK-NEXT:    .cfi_offset %rbp, -16
; CHECK-NEXT:    movq %rsp, %rbp
; CHECK-NEXT:    .cfi_def_cfa_register %rbp
; CHECK-NEXT:    andq $-32, %rsp
; CHECK-NEXT:    subq $96, %rsp
; CHECK-NEXT:    vmovaps %ymm0, (%rsp)
; CHECK-NEXT:    vmovdqa (%rsp), %xmm0
; CHECK-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],mem[0],xmm0[1],mem[1],xmm0[2],mem[2],xmm0[3],mem[3]
; CHECK-NEXT:    vmovdqa %ymm0, {{[0-9]+}}(%rsp)
; CHECK-NEXT:    vmovaps {{[0-9]+}}(%rsp), %xmm0
; CHECK-NEXT:    movq %rbp, %rsp
; CHECK-NEXT:    popq %rbp
; CHECK-NEXT:    .cfi_def_cfa %rsp, 8
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
  %s = shufflevector <16 x bfloat> %a, <16 x bfloat> zeroinitializer, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>
  %s2 = shufflevector <16 x bfloat> %s, <16 x bfloat> zeroinitializer, <2 x i32> <i32 0, i32 1>
  ret <2 x bfloat> %s2
}

define <2 x bfloat> @shuffle_chained_v8bf16(<8 x bfloat> %a) {
; CHECK-LABEL: shuffle_chained_v8bf16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,8,9,2,3,10,11,4,5,12,13,6,7,14,15]
; CHECK-NEXT:    retq
  %s = shufflevector <8 x bfloat> %a, <8 x bfloat> zeroinitializer, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>
  %s2 = shufflevector <8 x bfloat> %s, <8 x bfloat> zeroinitializer, <2 x i32> <i32 0, i32 1>
  ret <2 x bfloat> %s2
}
