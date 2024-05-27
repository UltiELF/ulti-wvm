; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-apple-macosx -mattr=+avx | FileCheck %s --check-prefixes=AVX,AVX1
; RUN: llc < %s -mtriple=x86_64-apple-macosx -mattr=+avx2 | FileCheck %s --check-prefixes=AVX,AVX2
; RUN: llc < %s -mtriple=x86_64-apple-macosx -mattr=+avx512vl | FileCheck %s --check-prefixes=AVX,AVX512

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"

; For this test we used to optimize the <i1 true, i1 false, i1 false, i1 true>
; mask into <i32 2147483648, i32 0, i32 0, i32 2147483648> because we thought
; we would lower that into a blend where only the high bit is relevant.
; However, since the whole mask is constant, this is simplified incorrectly
; by the generic code, because it was expecting -1 in place of 2147483648.
;
; The problem does not occur without AVX, because vselect of v4i32 is not legal
; nor custom.
;
; <rdar://problem/18675020>

define void @test(ptr %a, ptr %b) {
; AVX-LABEL: test:
; AVX:       ## %bb.0: ## %body
; AVX-NEXT:    movabsq $4167800517033787389, %rax ## imm = 0x39D7007D007CFFFD
; AVX-NEXT:    movq %rax, (%rdi)
; AVX-NEXT:    movabsq $-281474976645121, %rax ## imm = 0xFFFF00000000FFFF
; AVX-NEXT:    movq %rax, (%rsi)
; AVX-NEXT:    retq
body:
  %predphi = select <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i16> <i16 -3, i16 545, i16 4385, i16 14807>, <4 x i16> <i16 123, i16 124, i16 125, i16 127>
  %predphi42 = select <4 x i1> <i1 true, i1 false, i1 false, i1 true>, <4 x i16> <i16 -1, i16 -1, i16 -1, i16 -1>, <4 x i16> zeroinitializer
  store <4 x i16> %predphi, ptr %a, align 8
  store <4 x i16> %predphi42, ptr %b, align 8
  ret void
}

; Improve code coverage.
;
; When shrinking the condition used into the select to match a blend, this
; test case exercises the path where the modified node is not the root
; of the condition.

define void @test2(ptr %call1559, i64 %indvars.iv4198, <4 x i1> %tmp1895) {
; AVX1-LABEL: test2:
; AVX1:       ## %bb.0: ## %bb
; AVX1-NEXT:    vpslld $31, %xmm0, %xmm0
; AVX1-NEXT:    vpmovsxdq %xmm0, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[2,3,2,3]
; AVX1-NEXT:    vpmovsxdq %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm0, %ymm1, %ymm0
; AVX1-NEXT:    movq (%rdi,%rsi,8), %rax
; AVX1-NEXT:    vbroadcastsd {{.*#+}} ymm1 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1]
; AVX1-NEXT:    vblendvpd %ymm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm1, %ymm0
; AVX1-NEXT:    vmovupd %ymm0, (%rax)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test2:
; AVX2:       ## %bb.0: ## %bb
; AVX2-NEXT:    vpslld $31, %xmm0, %xmm0
; AVX2-NEXT:    vpmovsxdq %xmm0, %ymm0
; AVX2-NEXT:    movq (%rdi,%rsi,8), %rax
; AVX2-NEXT:    vbroadcastsd {{.*#+}} ymm1 = [-5.0E-1,-5.0E-1,-5.0E-1,-5.0E-1]
; AVX2-NEXT:    vbroadcastsd {{.*#+}} ymm2 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1]
; AVX2-NEXT:    vblendvpd %ymm0, %ymm1, %ymm2, %ymm0
; AVX2-NEXT:    vmovupd %ymm0, (%rax)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test2:
; AVX512:       ## %bb.0: ## %bb
; AVX512-NEXT:    vpslld $31, %xmm0, %xmm0
; AVX512-NEXT:    vptestmd %xmm0, %xmm0, %k1
; AVX512-NEXT:    movq (%rdi,%rsi,8), %rax
; AVX512-NEXT:    vbroadcastsd {{.*#+}} ymm0 = [5.0E-1,5.0E-1,5.0E-1,5.0E-1]
; AVX512-NEXT:    vbroadcastsd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0 {%k1}
; AVX512-NEXT:    vmovupd %ymm0, (%rax)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
bb:
  %arrayidx1928 = getelementptr inbounds ptr, ptr %call1559, i64 %indvars.iv4198
  %tmp1888 = load ptr, ptr %arrayidx1928, align 8
  %predphi.v.v = select <4 x i1> %tmp1895, <4 x double> <double -5.000000e-01, double -5.000000e-01, double -5.000000e-01, double -5.000000e-01>, <4 x double> <double 5.000000e-01, double 5.000000e-01, double 5.000000e-01, double 5.000000e-01>
  store <4 x double> %predphi.v.v, ptr %tmp1888, align 8
  ret void
}

; For this test, we used to optimized the conditional mask for the blend, i.e.,
; we shrunk some of its bits.
; However, this same mask was used in another select (%predphi31) that turned out
; to be optimized into a and. In that case, the conditional mask was wrong.
;
; Make sure that the and is fed by the original mask.
;
; <rdar://problem/18819506>

define void @test3(<4 x i32> %induction30, ptr %tmp16, ptr %tmp17,  <4 x i16> %tmp3, <4 x i16> %tmp12) {
; AVX1-LABEL: test3:
; AVX1:       ## %bb.0:
; AVX1-NEXT:    vpmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vpaddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vpminud {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm3
; AVX1-NEXT:    vpcmpeqd %xmm3, %xmm0, %xmm0
; AVX1-NEXT:    vpackssdw %xmm0, %xmm0, %xmm0
; AVX1-NEXT:    vpblendvb %xmm0, %xmm1, %xmm2, %xmm1
; AVX1-NEXT:    vmovq %xmm0, (%rdi)
; AVX1-NEXT:    vmovq %xmm1, (%rsi)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test3:
; AVX2:       ## %bb.0:
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm3 = [2863311531,2863311531,2863311531,2863311531]
; AVX2-NEXT:    vpmulld %xmm3, %xmm0, %xmm0
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm3 = [715827882,715827882,715827882,715827882]
; AVX2-NEXT:    vpaddd %xmm3, %xmm0, %xmm0
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm3 = [1431655764,1431655764,1431655764,1431655764]
; AVX2-NEXT:    vpminud %xmm3, %xmm0, %xmm3
; AVX2-NEXT:    vpcmpeqd %xmm3, %xmm0, %xmm0
; AVX2-NEXT:    vpackssdw %xmm0, %xmm0, %xmm0
; AVX2-NEXT:    vpblendvb %xmm0, %xmm1, %xmm2, %xmm1
; AVX2-NEXT:    vmovq %xmm0, (%rdi)
; AVX2-NEXT:    vmovq %xmm1, (%rsi)
; AVX2-NEXT:    retq
;
; AVX512-LABEL: test3:
; AVX512:       ## %bb.0:
; AVX512-NEXT:    vpmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %xmm0
; AVX512-NEXT:    vpaddd {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %xmm0
; AVX512-NEXT:    vpcmpleud {{\.?LCPI[0-9]+_[0-9]+}}(%rip){1to4}, %xmm0, %k1
; AVX512-NEXT:    vpcmpeqd %ymm0, %ymm0, %ymm0
; AVX512-NEXT:    vmovdqa32 %ymm0, %ymm0 {%k1} {z}
; AVX512-NEXT:    vpmovdw %ymm0, %xmm0
; AVX512-NEXT:    vpternlogq $226, %xmm2, %xmm0, %xmm1
; AVX512-NEXT:    vmovq %xmm0, (%rdi)
; AVX512-NEXT:    vmovq %xmm1, (%rsi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %tmp6 = srem <4 x i32> %induction30, <i32 3, i32 3, i32 3, i32 3>
  %tmp7 = icmp eq <4 x i32> %tmp6, zeroinitializer
  %predphi = select <4 x i1> %tmp7, <4 x i16> %tmp3, <4 x i16> %tmp12
  %predphi31 = select <4 x i1> %tmp7, <4 x i16> <i16 -1, i16 -1, i16 -1, i16 -1>, <4 x i16> zeroinitializer

  store <4 x i16> %predphi31, ptr %tmp16, align 8
  store <4 x i16> %predphi, ptr %tmp17, align 8
 ret void
}

; We shouldn't try to lower this directly using VSELECT because we don't have
; vpblendvb in AVX1, only in AVX2. Instead, it should be expanded.

define <32 x i8> @PR22706(<32 x i1> %x) {
; AVX1-LABEL: PR22706:
; AVX1:       ## %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpsllw $7, %xmm1, %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm2 = [128,128,128,128,128,128,128,128,128,128,128,128,128,128,128,128]
; AVX1-NEXT:    vpand %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpxor %xmm3, %xmm3, %xmm3
; AVX1-NEXT:    vpcmpgtb %xmm1, %xmm3, %xmm1
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm4 = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
; AVX1-NEXT:    vpaddb %xmm4, %xmm1, %xmm1
; AVX1-NEXT:    vpsllw $7, %xmm0, %xmm0
; AVX1-NEXT:    vpand %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpcmpgtb %xmm0, %xmm3, %xmm0
; AVX1-NEXT:    vpaddb %xmm4, %xmm0, %xmm0
; AVX1-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; AVX1-NEXT:    retq
;
; AVX2-LABEL: PR22706:
; AVX2:       ## %bb.0:
; AVX2-NEXT:    vpsllw $7, %ymm0, %ymm0
; AVX2-NEXT:    vpand {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm0
; AVX2-NEXT:    vpxor %xmm1, %xmm1, %xmm1
; AVX2-NEXT:    vpcmpgtb %ymm0, %ymm1, %ymm0
; AVX2-NEXT:    vpaddb {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm0, %ymm0
; AVX2-NEXT:    retq
;
; AVX512-LABEL: PR22706:
; AVX512:       ## %bb.0:
; AVX512-NEXT:    vpsllw $7, %ymm0, %ymm0
; AVX512-NEXT:    vpbroadcastd {{.*#+}} ymm1 = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
; AVX512-NEXT:    vpblendvb %ymm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %ymm1, %ymm0
; AVX512-NEXT:    retq
  %tmp = select <32 x i1> %x, <32 x i8> <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>, <32 x i8> <i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2, i8 2>
  ret <32 x i8> %tmp
}

; Don't concat select/blendv ops if the concatenated mask isn't legal.
define void @PR59003(<2 x float> %0, <2 x float> %1, <8 x i1> %shuffle108) {
; AVX-LABEL: PR59003:
; AVX:       ## %bb.0: ## %entry
; AVX-NEXT:    .p2align 4, 0x90
; AVX-NEXT:  LBB4_1: ## %for.body.i
; AVX-NEXT:    ## =>This Inner Loop Header: Depth=1
; AVX-NEXT:    jmp LBB4_1
entry:
  br label %for.body.i

for.body.i:                                       ; preds = %for.body.i, %entry
  %2 = phi <8 x float> [ zeroinitializer, %entry ], [ %3, %for.body.i ]
  %shuffle111 = shufflevector <2 x float> %0, <2 x float> zeroinitializer, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  %shuffle112 = shufflevector <2 x float> %1, <2 x float> zeroinitializer, <8 x i32> <i32 0, i32 1, i32 0, i32 1, i32 0, i32 1, i32 0, i32 1>
  %3 = select <8 x i1> %shuffle108, <8 x float> %shuffle111, <8 x float> %shuffle112
  %4 = shufflevector <8 x float> zeroinitializer, <8 x float> %2, <8 x i32> <i32 0, i32 9, i32 2, i32 11, i32 4, i32 13, i32 6, i32 15>
  %5 = select <8 x i1> zeroinitializer, <8 x float> zeroinitializer, <8 x float> %2
  br label %for.body.i
}


; Split a 256-bit select into two 128-bit selects when the operands are concatenated.

define void @blendv_split(ptr %p, <8 x i32> %cond, <8 x i32> %a, <8 x i32> %x, <8 x i32> %y, <8 x i32> %z, <8 x i32> %w) {
; AVX1-LABEL: blendv_split:
; AVX1:       ## %bb.0:
; AVX1-NEXT:    vextractf128 $1, %ymm1, %xmm4
; AVX1-NEXT:    vpmovzxdq {{.*#+}} xmm2 = xmm2[0],zero,xmm2[1],zero
; AVX1-NEXT:    vpslld %xmm2, %xmm4, %xmm5
; AVX1-NEXT:    vpslld %xmm2, %xmm1, %xmm2
; AVX1-NEXT:    vpmovzxdq {{.*#+}} xmm3 = xmm3[0],zero,xmm3[1],zero
; AVX1-NEXT:    vpslld %xmm3, %xmm4, %xmm4
; AVX1-NEXT:    vpslld %xmm3, %xmm1, %xmm1
; AVX1-NEXT:    vblendvps %xmm0, %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm0
; AVX1-NEXT:    vblendvps %xmm0, %xmm5, %xmm4, %xmm0
; AVX1-NEXT:    vmovups %xmm0, 16(%rdi)
; AVX1-NEXT:    vmovups %xmm1, (%rdi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: blendv_split:
; AVX2:       ## %bb.0:
; AVX2-NEXT:    vpmovzxdq {{.*#+}} xmm2 = xmm2[0],zero,xmm2[1],zero
; AVX2-NEXT:    vpslld %xmm2, %ymm1, %ymm2
; AVX2-NEXT:    vpmovzxdq {{.*#+}} xmm3 = xmm3[0],zero,xmm3[1],zero
; AVX2-NEXT:    vpslld %xmm3, %ymm1, %ymm1
; AVX2-NEXT:    vblendvps %ymm0, %ymm2, %ymm1, %ymm0
; AVX2-NEXT:    vmovups %ymm0, (%rdi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: blendv_split:
; AVX512:       ## %bb.0:
; AVX512-NEXT:    vpsrld $31, %ymm0, %ymm0
; AVX512-NEXT:    vpslld $31, %ymm0, %ymm0
; AVX512-NEXT:    vptestmd %ymm0, %ymm0, %k1
; AVX512-NEXT:    vpmovzxdq {{.*#+}} xmm0 = xmm2[0],zero,xmm2[1],zero
; AVX512-NEXT:    vpmovzxdq {{.*#+}} xmm2 = xmm3[0],zero,xmm3[1],zero
; AVX512-NEXT:    vpslld %xmm2, %ymm1, %ymm2
; AVX512-NEXT:    vpslld %xmm0, %ymm1, %ymm2 {%k1}
; AVX512-NEXT:    vmovdqu %ymm2, (%rdi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %signbits = ashr <8 x i32> %cond, <i32 31, i32 31, i32 31, i32 31, i32 31, i32 31, i32 31, i32 31>
  %bool = trunc <8 x i32> %signbits to <8 x i1>
  %shamt1 = shufflevector <8 x i32> %x, <8 x i32> undef, <8 x i32> zeroinitializer
  %shamt2 = shufflevector <8 x i32> %y, <8 x i32> undef, <8 x i32> zeroinitializer
  %sh1 = shl <8 x i32> %a, %shamt1
  %sh2 = shl <8 x i32> %a, %shamt2
  %sel = select <8 x i1> %bool, <8 x i32> %sh1, <8 x i32> %sh2
  store <8 x i32> %sel, ptr %p, align 4
  ret void
}

; Regression test for rGea8fb3b60196
define void @vselect_concat() {
; AVX-LABEL: vselect_concat:
; AVX:       ## %bb.0: ## %entry
; AVX-NEXT:    retq
entry:
  %0 = load <8 x i32>, ptr undef
  %1 = shufflevector <8 x i32> zeroinitializer, <8 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %2 = shufflevector <8 x i32> %0, <8 x i32> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = select <4 x i1> zeroinitializer, <4 x i32> %1, <4 x i32> %2
  %4 = shufflevector <8 x i32> zeroinitializer, <8 x i32> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %5 = shufflevector <8 x i32> %0, <8 x i32> undef, <4 x i32> <i32 4, i32 5, i32 6, i32 7>
  %6 = select <4 x i1> zeroinitializer, <4 x i32> %4, <4 x i32> %5
  %7 = shufflevector <4 x i32> %3, <4 x i32> %6, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  store <8 x i32> %7, ptr undef
  ret void
}

; Regression test for rGb5d7beeb9792
define void @vselect_concat_splat() {
; AVX1-LABEL: vselect_concat_splat:
; AVX1:       ## %bb.0: ## %entry
; AVX1-NEXT:    vmovups (%rax), %xmm0
; AVX1-NEXT:    vshufps {{.*#+}} xmm1 = xmm0[0,3,2,1]
; AVX1-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[1,0,3,2]
; AVX1-NEXT:    vmovups 16, %xmm2
; AVX1-NEXT:    vmovups 32, %xmm3
; AVX1-NEXT:    vblendps {{.*#+}} xmm4 = mem[0],xmm3[1],mem[2,3]
; AVX1-NEXT:    vblendps {{.*#+}} xmm4 = xmm4[0,1],xmm2[2],xmm4[3]
; AVX1-NEXT:    vshufps {{.*#+}} xmm4 = xmm4[0,3,2,1]
; AVX1-NEXT:    vblendps {{.*#+}} xmm3 = mem[0,1],xmm3[2,3]
; AVX1-NEXT:    vblendps {{.*#+}} xmm2 = xmm2[0],xmm3[1,2],xmm2[3]
; AVX1-NEXT:    vshufps {{.*#+}} xmm2 = xmm2[1,0,3,2]
; AVX1-NEXT:    vxorps %xmm3, %xmm3, %xmm3
; AVX1-NEXT:    vcmpneqps %xmm3, %xmm1, %xmm3
; AVX1-NEXT:    vblendvps %xmm3, %xmm4, %xmm1, %xmm1
; AVX1-NEXT:    vblendvps %xmm3, %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vmovups %xmm0, (%rax)
; AVX1-NEXT:    vmovups %xmm1, (%rax)
; AVX1-NEXT:    retq
;
; AVX2-LABEL: vselect_concat_splat:
; AVX2:       ## %bb.0: ## %entry
; AVX2-NEXT:    vmovups (%rax), %ymm0
; AVX2-NEXT:    vmovups (%rax), %xmm1
; AVX2-NEXT:    vmovaps {{.*#+}} xmm2 = [0,3,6,1]
; AVX2-NEXT:    vblendps {{.*#+}} ymm3 = ymm0[0],ymm1[1],ymm0[2,3,4,5,6,7]
; AVX2-NEXT:    vpermps %ymm3, %ymm2, %ymm3
; AVX2-NEXT:    vmovaps {{.*#+}} xmm4 = [1,4,7,2]
; AVX2-NEXT:    vblendps {{.*#+}} ymm0 = ymm0[0,1],ymm1[2,3],ymm0[4,5,6,7]
; AVX2-NEXT:    vpermps %ymm0, %ymm4, %ymm0
; AVX2-NEXT:    vmovups 0, %ymm1
; AVX2-NEXT:    vmovups 32, %xmm5
; AVX2-NEXT:    vblendps {{.*#+}} ymm6 = ymm1[0],ymm5[1],ymm1[2,3,4,5,6,7]
; AVX2-NEXT:    vpermps %ymm6, %ymm2, %ymm2
; AVX2-NEXT:    vblendps {{.*#+}} ymm1 = ymm1[0,1],ymm5[2,3],ymm1[4,5,6,7]
; AVX2-NEXT:    vpermps %ymm1, %ymm4, %ymm1
; AVX2-NEXT:    vxorps %xmm4, %xmm4, %xmm4
; AVX2-NEXT:    vcmpneqps %xmm4, %xmm3, %xmm4
; AVX2-NEXT:    vblendvps %xmm4, %xmm2, %xmm3, %xmm2
; AVX2-NEXT:    vblendvps %xmm4, %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vmovups %xmm0, (%rax)
; AVX2-NEXT:    vmovups %xmm2, (%rax)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512-LABEL: vselect_concat_splat:
; AVX512:       ## %bb.0: ## %entry
; AVX512-NEXT:    vmovups (%rax), %ymm0
; AVX512-NEXT:    vmovups (%rax), %xmm1
; AVX512-NEXT:    vmovaps {{.*#+}} ymm2 = [0,3,6,9,1,4,7,10]
; AVX512-NEXT:    vmovaps %ymm2, %ymm3
; AVX512-NEXT:    vpermi2ps %ymm1, %ymm0, %ymm3
; AVX512-NEXT:    vmovups 32, %xmm4
; AVX512-NEXT:    vmovups 0, %ymm5
; AVX512-NEXT:    vxorps %xmm6, %xmm6, %xmm6
; AVX512-NEXT:    vcmpneqps %xmm6, %xmm3, %k0
; AVX512-NEXT:    kshiftlw $4, %k0, %k1
; AVX512-NEXT:    korw %k1, %k0, %k1
; AVX512-NEXT:    vpermt2ps %ymm4, %ymm2, %ymm5
; AVX512-NEXT:    vpermt2ps %ymm1, %ymm2, %ymm0
; AVX512-NEXT:    vmovaps %ymm5, %ymm0 {%k1}
; AVX512-NEXT:    vmovups %ymm0, (%rax)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
entry:
  %wide.vec = load <12 x float>, ptr undef, align 1
  %strided.vec = shufflevector <12 x float> %wide.vec, <12 x float> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %strided.vec29 = shufflevector <12 x float> %wide.vec, <12 x float> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %wide.vec31 = load <12 x float>, ptr null, align 1
  %strided.vec32 = shufflevector <12 x float> %wide.vec31, <12 x float> poison, <4 x i32> <i32 0, i32 3, i32 6, i32 9>
  %strided.vec33 = shufflevector <12 x float> %wide.vec31, <12 x float> poison, <4 x i32> <i32 1, i32 4, i32 7, i32 10>
  %i = select i1 false, <4 x float> zeroinitializer, <4 x float> %strided.vec
  %i1 = fcmp une <4 x float> %i, zeroinitializer
  %i2 = select <4 x i1> %i1, <4 x float> %strided.vec32, <4 x float> %strided.vec
  %.v = select <4 x i1> %i1, <4 x float> %strided.vec33, <4 x float> %strided.vec29
  %.uncasted = shufflevector <4 x float> %i2, <4 x float> %.v, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  store <8 x float>  %.uncasted, ptr undef, align 1
  ret void
}
