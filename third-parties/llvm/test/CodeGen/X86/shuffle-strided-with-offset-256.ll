; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefixes=AVX,AVX2,AVX2-SLOW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX2,AVX2-FAST
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX,AVX2,AVX2-FAST
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefixes=AVX512,AVX512F
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX512,AVX512VL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX512,AVX512VL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX512,AVX512BW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX512,AVX512BW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,+avx512vl,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX512,AVX512BWVL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,+avx512vl,+fast-variable-perlane-shuffle | FileCheck %s --check-prefixes=AVX512,AVX512BWVL

define void @shuffle_v32i8_to_v16i8_1(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vmovddup {{.*#+}} xmm2 = [1,3,5,7,9,11,13,15,1,3,5,7,9,11,13,15]
; AVX1-NEXT:    # xmm2 = mem[0,0]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX1-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastq {{.*#+}} xmm2 = [1,3,5,7,9,11,13,15,1,3,5,7,9,11,13,15]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX2-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %xmm0
; AVX512F-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX512F-NEXT:    vpbroadcastq {{.*#+}} xmm2 = [1,3,5,7,9,11,13,15,1,3,5,7,9,11,13,15]
; AVX512F-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX512F-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX512F-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX512F-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovdqa (%rdi), %xmm0
; AVX512VL-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX512VL-NEXT:    vpbroadcastq {{.*#+}} xmm2 = [1,3,5,7,9,11,13,15,1,3,5,7,9,11,13,15]
; AVX512VL-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX512VL-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX512VL-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX512VL-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovwb %zmm0, %ymm0
; AVX512BW-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlw $8, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovwb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <16 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15, i32 17, i32 19, i32 21, i32 23, i32 25, i32 27, i32 29, i32 31>
  store <16 x i8> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v16i16_to_v8i16_1(ptr %L, ptr %S) nounwind {
; AVX-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovdqa (%rdi), %xmm0
; AVX-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX-NEXT:    vpsrld $16, %xmm1, %xmm1
; AVX-NEXT:    vpsrld $16, %xmm0, %xmm0
; AVX-NEXT:    vpackusdw %xmm1, %xmm0, %xmm0
; AVX-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512F-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovdw %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512BW-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovdw %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <16 x i16>, ptr %L
  %strided.vec = shufflevector <16 x i16> %vec, <16 x i16> undef, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  store <8 x i16> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v8i32_to_v4i32_1(ptr %L, ptr %S) nounwind {
; AVX-LABEL: shuffle_v8i32_to_v4i32_1:
; AVX:       # %bb.0:
; AVX-NEXT:    vmovaps (%rdi), %xmm0
; AVX-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[1,3],mem[1,3]
; AVX-NEXT:    vmovaps %xmm0, (%rsi)
; AVX-NEXT:    retq
;
; AVX512-LABEL: shuffle_v8i32_to_v4i32_1:
; AVX512:       # %bb.0:
; AVX512-NEXT:    vmovaps (%rdi), %xmm0
; AVX512-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[1,3],mem[1,3]
; AVX512-NEXT:    vmovaps %xmm0, (%rsi)
; AVX512-NEXT:    retq
  %vec = load <8 x i32>, ptr %L
  %strided.vec = shufflevector <8 x i32> %vec, <8 x i32> undef, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  store <4 x i32> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v32i8_to_v8i8_1(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [1,5,9,13,1,5,9,13,1,5,9,13,1,5,9,13]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [1,5,9,13,1,5,9,13,1,5,9,13,1,5,9,13]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX2-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrld $8, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrld $8, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrld $8, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrld $8, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  store <8 x i8> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v32i8_to_v8i8_2(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [2,6,10,14,2,6,10,14,2,6,10,14,2,6,10,14]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [2,6,10,14,2,6,10,14,2,6,10,14,2,6,10,14]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX2-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  store <8 x i8> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v32i8_to_v8i8_3(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [3,7,11,15,3,7,11,15,3,7,11,15,3,7,11,15]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [3,7,11,15,3,7,11,15,3,7,11,15,3,7,11,15]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX2-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrld $24, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrld $24, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrld $24, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrld $24, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  store <8 x i8> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v16i16_to_v4i16_1(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = mem[0,2,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[1,3,2,3,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = mem[0,2,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm1[1,3,2,3,4,5,6,7]
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-SLOW-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX2-SLOW:       # %bb.0:
; AVX2-SLOW-NEXT:    vpshufd {{.*#+}} xmm0 = mem[0,2,2,3]
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[1,3,2,3,4,5,6,7]
; AVX2-SLOW-NEXT:    vpshufd {{.*#+}} xmm1 = mem[0,2,2,3]
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm1[1,3,2,3,4,5,6,7]
; AVX2-SLOW-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; AVX2-SLOW-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-SLOW-NEXT:    retq
;
; AVX2-FAST-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX2-FAST:       # %bb.0:
; AVX2-FAST-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-FAST-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-FAST-NEXT:    vmovdqa {{.*#+}} xmm2 = [2,3,10,11,8,9,10,11,8,9,10,11,12,13,14,15]
; AVX2-FAST-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-FAST-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-FAST-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX2-FAST-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-FAST-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $16, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqw %zmm0, %xmm0
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlq $16, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $16, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqw %zmm0, %xmm0
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlq $16, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <16 x i16>, ptr %L
  %strided.vec = shufflevector <16 x i16> %vec, <16 x i16> undef, <4 x i32> <i32 1, i32 5, i32 9, i32 13>
  store <4 x i16> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v16i16_to_v4i16_2(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = mem[3,1,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[2,0,2,3,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = mem[3,1,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm1[2,0,2,3,4,5,6,7]
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-SLOW-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX2-SLOW:       # %bb.0:
; AVX2-SLOW-NEXT:    vpshufd {{.*#+}} xmm0 = mem[3,1,2,3]
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[2,0,2,3,4,5,6,7]
; AVX2-SLOW-NEXT:    vpshufd {{.*#+}} xmm1 = mem[3,1,2,3]
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm1[2,0,2,3,4,5,6,7]
; AVX2-SLOW-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; AVX2-SLOW-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-SLOW-NEXT:    retq
;
; AVX2-FAST-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX2-FAST:       # %bb.0:
; AVX2-FAST-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-FAST-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-FAST-NEXT:    vmovdqa {{.*#+}} xmm2 = [4,5,12,13,4,5,6,7,8,9,10,11,12,13,14,15]
; AVX2-FAST-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-FAST-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-FAST-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX2-FAST-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-FAST-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $32, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqw %zmm0, %xmm0
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlq $32, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $32, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqw %zmm0, %xmm0
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlq $32, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <16 x i16>, ptr %L
  %strided.vec = shufflevector <16 x i16> %vec, <16 x i16> undef, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
  store <4 x i16> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v16i16_to_v4i16_3(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = mem[3,1,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[3,1,2,3,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = mem[3,1,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm1[3,1,2,3,4,5,6,7]
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-SLOW-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX2-SLOW:       # %bb.0:
; AVX2-SLOW-NEXT:    vpshufd {{.*#+}} xmm0 = mem[3,1,2,3]
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[3,1,2,3,4,5,6,7]
; AVX2-SLOW-NEXT:    vpshufd {{.*#+}} xmm1 = mem[3,1,2,3]
; AVX2-SLOW-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm1[3,1,2,3,4,5,6,7]
; AVX2-SLOW-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; AVX2-SLOW-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-SLOW-NEXT:    retq
;
; AVX2-FAST-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX2-FAST:       # %bb.0:
; AVX2-FAST-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-FAST-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-FAST-NEXT:    vmovdqa {{.*#+}} xmm2 = [6,7,14,15,4,5,6,7,8,9,10,11,12,13,14,15]
; AVX2-FAST-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-FAST-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-FAST-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX2-FAST-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-FAST-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $48, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqw %zmm0, %xmm0
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlq $48, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $48, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqw %zmm0, %xmm0
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlq $48, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <16 x i16>, ptr %L
  %strided.vec = shufflevector <16 x i16> %vec, <16 x i16> undef, <4 x i32> <i32 3, i32 7, i32 11, i32 15>
  store <4 x i16> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_1(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [1,9,0,0,1,9,0,0,1,9,0,0,1,9,0,0]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm2 = [1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $8, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlq $8, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $8, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlq $8, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 1, i32 9, i32 17, i32 25>
  store <4 x i8> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_2(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [2,10,0,0,2,10,0,0,2,10,0,0,2,10,0,0]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm2 = [2,10,2,10,2,10,2,10,2,10,2,10,2,10,2,10]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $16, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlq $16, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $16, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlq $16, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 2, i32 10, i32 18, i32 26>
  store <4 x i8> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_3(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [3,11,0,0,3,11,0,0,3,11,0,0,3,11,0,0]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm2 = [3,11,3,11,3,11,3,11,3,11,3,11,3,11,3,11]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $24, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlq $24, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $24, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlq $24, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 3, i32 11, i32 19, i32 27>
  store <4 x i8> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_4(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [4,12,0,0,4,12,0,0,4,12,0,0,4,12,0,0]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm2 = [4,12,4,12,4,12,4,12,4,12,4,12,4,12,4,12]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $32, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlq $32, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $32, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlq $32, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 4, i32 12, i32 20, i32 28>
  store <4 x i8> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_5(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [5,13,0,0,5,13,0,0,5,13,0,0,5,13,0,0]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm2 = [5,13,5,13,5,13,5,13,5,13,5,13,5,13,5,13]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $40, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlq $40, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $40, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlq $40, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 5, i32 13, i32 21, i32 29>
  store <4 x i8> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_6(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [6,14,0,0,6,14,0,0,6,14,0,0,6,14,0,0]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm2 = [6,14,6,14,6,14,6,14,6,14,6,14,6,14,6,14]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $48, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlq $48, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $48, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlq $48, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 6, i32 14, i32 22, i32 30>
  store <4 x i8> %strided.vec, ptr %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_7(ptr %L, ptr %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovdqa (%rdi), %xmm0
; AVX1-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [7,15,0,0,7,15,0,0,7,15,0,0,7,15,0,0]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vpbroadcastw {{.*#+}} xmm2 = [7,15,7,15,7,15,7,15,7,15,7,15,7,15,7,15]
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX512F:       # %bb.0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $56, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vpsrlq $56, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX512BW:       # %bb.0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $56, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqb %zmm0, %xmm0
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX512BWVL:       # %bb.0:
; AVX512BWVL-NEXT:    vpsrlq $56, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, ptr %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 7, i32 15, i32 23, i32 31>
  store <4 x i8> %strided.vec, ptr %S
  ret void
}

