; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s

define void @f(ptr %a, ptr %b, ptr %c) {
; CHECK-LABEL: f:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pinsrw $0, (%rdi), %xmm0
; CHECK-NEXT:    pinsrw $0, 2(%rdi), %xmm1
; CHECK-NEXT:    pinsrw $0, 4(%rdi), %xmm2
; CHECK-NEXT:    pinsrw $0, 6(%rdi), %xmm3
; CHECK-NEXT:    pinsrw $0, (%rsi), %xmm4
; CHECK-NEXT:    pinsrw $0, 2(%rsi), %xmm5
; CHECK-NEXT:    pinsrw $0, 4(%rsi), %xmm6
; CHECK-NEXT:    pinsrw $0, 6(%rsi), %xmm7
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm3 = xmm3[0],xmm7[0],xmm3[1],xmm7[1],xmm3[2],xmm7[2],xmm3[3],xmm7[3]
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm2 = xmm2[0],xmm6[0],xmm2[1],xmm6[1],xmm2[2],xmm6[2],xmm2[3],xmm6[3]
; CHECK-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm1 = xmm1[0],xmm5[0],xmm1[1],xmm5[1],xmm1[2],xmm5[2],xmm1[3],xmm5[3]
; CHECK-NEXT:    punpcklwd {{.*#+}} xmm0 = xmm0[0],xmm4[0],xmm0[1],xmm4[1],xmm0[2],xmm4[2],xmm0[3],xmm4[3]
; CHECK-NEXT:    punpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; CHECK-NEXT:    punpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm2[0]
; CHECK-NEXT:    movdqa %xmm0, (%rdx)
; CHECK-NEXT:    retq
  %tmp4 = load <4 x half>, ptr %a
  %tmp5 = load <4 x half>, ptr %b
  %tmp7 = shufflevector <4 x half> %tmp4, <4 x half> %tmp5, <2 x i32> <i32 0, i32 4>
  %tmp8 = shufflevector <4 x half> %tmp4, <4 x half> %tmp5, <2 x i32> <i32 1, i32 5>
  %tmp9 = shufflevector <4 x half> %tmp4, <4 x half> %tmp5, <2 x i32> <i32 2, i32 6>
  %tmp10 = shufflevector <4 x half> %tmp4, <4 x half> %tmp5, <2 x i32> <i32 3, i32 7>
  %tmp11 = extractelement <2 x half> %tmp7, i32 0
  %tmp12 = insertelement <8 x half> undef, half %tmp11, i32 0
  %tmp13 = extractelement <2 x half> %tmp7, i32 1
  %tmp14 = insertelement <8 x half> %tmp12, half %tmp13, i32 1
  %tmp15 = extractelement <2 x half> %tmp8, i32 0
  %tmp16 = insertelement <8 x half> %tmp14, half %tmp15, i32 2
  %tmp17 = extractelement <2 x half> %tmp8, i32 1
  %tmp18 = insertelement <8 x half> %tmp16, half %tmp17, i32 3
  %tmp19 = extractelement <2 x half> %tmp9, i32 0
  %tmp20 = insertelement <8 x half> %tmp18, half %tmp19, i32 4
  %tmp21 = extractelement <2 x half> %tmp9, i32 1
  %tmp22 = insertelement <8 x half> %tmp20, half %tmp21, i32 5
  %tmp23 = extractelement <2 x half> %tmp10, i32 0
  %tmp24 = insertelement <8 x half> %tmp22, half %tmp23, i32 6
  %tmp25 = extractelement <2 x half> %tmp10, i32 1
  %tmp26 = insertelement <8 x half> %tmp24, half %tmp25, i32 7
  store <8 x half> %tmp26, ptr %c
  ret void
}
