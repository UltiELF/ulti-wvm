; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=i686-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=X86
; RUN: llc -mtriple=x86_64-unknown-linux-gnu < %s | FileCheck %s --check-prefixes=X64
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+sse2 < %s | FileCheck %s --check-prefixes=X64,SSE2
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+sse4.1 < %s | FileCheck %s --check-prefixes=X64,SSE41
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+avx < %s | FileCheck %s --check-prefixes=X64,AVX1
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+avx2 < %s | FileCheck %s --check-prefixes=X64,AVX2
; RUN: llc -mtriple=x86_64-unknown-linux-gnu -mattr=+avx512f,+avx512vl < %s | FileCheck %s --check-prefixes=X64,AVX512VL

define i1 @test_urem_odd(i13 %X) nounwind {
; X86-LABEL: test_urem_odd:
; X86:       # %bb.0:
; X86-NEXT:    imull $3277, {{[0-9]+}}(%esp), %eax # imm = 0xCCD
; X86-NEXT:    andl $8191, %eax # imm = 0x1FFF
; X86-NEXT:    cmpl $1639, %eax # imm = 0x667
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_odd:
; X64:       # %bb.0:
; X64-NEXT:    imull $3277, %edi, %eax # imm = 0xCCD
; X64-NEXT:    andl $8191, %eax # imm = 0x1FFF
; X64-NEXT:    cmpl $1639, %eax # imm = 0x667
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %urem = urem i13 %X, 5
  %cmp = icmp eq i13 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_even(i27 %X) nounwind {
; X86-LABEL: test_urem_even:
; X86:       # %bb.0:
; X86-NEXT:    imull $115043767, {{[0-9]+}}(%esp), %eax # imm = 0x6DB6DB7
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shll $26, %ecx
; X86-NEXT:    andl $134217726, %eax # imm = 0x7FFFFFE
; X86-NEXT:    shrl %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    andl $134217727, %eax # imm = 0x7FFFFFF
; X86-NEXT:    cmpl $9586981, %eax # imm = 0x924925
; X86-NEXT:    setb %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_even:
; X64:       # %bb.0:
; X64-NEXT:    imull $115043767, %edi, %eax # imm = 0x6DB6DB7
; X64-NEXT:    movl %eax, %ecx
; X64-NEXT:    shll $26, %ecx
; X64-NEXT:    andl $134217726, %eax # imm = 0x7FFFFFE
; X64-NEXT:    shrl %eax
; X64-NEXT:    orl %ecx, %eax
; X64-NEXT:    andl $134217727, %eax # imm = 0x7FFFFFF
; X64-NEXT:    cmpl $9586981, %eax # imm = 0x924925
; X64-NEXT:    setb %al
; X64-NEXT:    retq
  %urem = urem i27 %X, 14
  %cmp = icmp eq i27 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_odd_setne(i4 %X) nounwind {
; X86-LABEL: test_urem_odd_setne:
; X86:       # %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    leal (%eax,%eax,2), %ecx
; X86-NEXT:    leal (%eax,%ecx,4), %eax
; X86-NEXT:    andb $15, %al
; X86-NEXT:    cmpb $4, %al
; X86-NEXT:    setae %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_odd_setne:
; X64:       # %bb.0:
; X64-NEXT:    # kill: def $edi killed $edi def $rdi
; X64-NEXT:    leal (%rdi,%rdi,2), %eax
; X64-NEXT:    leal (%rdi,%rax,4), %eax
; X64-NEXT:    andb $15, %al
; X64-NEXT:    cmpb $4, %al
; X64-NEXT:    setae %al
; X64-NEXT:    retq
  %urem = urem i4 %X, 5
  %cmp = icmp ne i4 %urem, 0
  ret i1 %cmp
}

define i1 @test_urem_negative_odd(i9 %X) nounwind {
; X86-LABEL: test_urem_negative_odd:
; X86:       # %bb.0:
; X86-NEXT:    imull $307, {{[0-9]+}}(%esp), %eax # imm = 0x133
; X86-NEXT:    andl $511, %eax # imm = 0x1FF
; X86-NEXT:    cmpw $2, %ax
; X86-NEXT:    setae %al
; X86-NEXT:    retl
;
; X64-LABEL: test_urem_negative_odd:
; X64:       # %bb.0:
; X64-NEXT:    imull $307, %edi, %eax # imm = 0x133
; X64-NEXT:    andl $511, %eax # imm = 0x1FF
; X64-NEXT:    cmpw $2, %ax
; X64-NEXT:    setae %al
; X64-NEXT:    retq
  %urem = urem i9 %X, -5
  %cmp = icmp ne i9 %urem, 0
  ret i1 %cmp
}

define <3 x i1> @test_urem_vec(<3 x i11> %X) nounwind {
; X86-LABEL: test_urem_vec:
; X86:       # %bb.0:
; X86-NEXT:    imull $683, {{[0-9]+}}(%esp), %eax # imm = 0x2AB
; X86-NEXT:    movl %eax, %ecx
; X86-NEXT:    shll $10, %ecx
; X86-NEXT:    andl $2046, %eax # imm = 0x7FE
; X86-NEXT:    shrl %eax
; X86-NEXT:    orl %ecx, %eax
; X86-NEXT:    andl $2047, %eax # imm = 0x7FF
; X86-NEXT:    cmpl $342, %eax # imm = 0x156
; X86-NEXT:    setae %al
; X86-NEXT:    imull $1463, {{[0-9]+}}(%esp), %ecx # imm = 0x5B7
; X86-NEXT:    addl $-1463, %ecx # imm = 0xFA49
; X86-NEXT:    andl $2047, %ecx # imm = 0x7FF
; X86-NEXT:    cmpl $293, %ecx # imm = 0x125
; X86-NEXT:    setae %dl
; X86-NEXT:    imull $819, {{[0-9]+}}(%esp), %ecx # imm = 0x333
; X86-NEXT:    addl $-1638, %ecx # imm = 0xF99A
; X86-NEXT:    andl $2047, %ecx # imm = 0x7FF
; X86-NEXT:    cmpw $2, %cx
; X86-NEXT:    setae %cl
; X86-NEXT:    retl
;
; SSE2-LABEL: test_urem_vec:
; SSE2:       # %bb.0:
; SSE2-NEXT:    movd %esi, %xmm0
; SSE2-NEXT:    movd %edi, %xmm1
; SSE2-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; SSE2-NEXT:    movd %edx, %xmm0
; SSE2-NEXT:    punpcklqdq {{.*#+}} xmm1 = xmm1[0],xmm0[0]
; SSE2-NEXT:    psubd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    movdqa {{.*#+}} xmm0 = [683,u,819,u]
; SSE2-NEXT:    pmuludq %xmm1, %xmm0
; SSE2-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[0,2,2,3]
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[1,1,1,1]
; SSE2-NEXT:    pmuludq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; SSE2-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; SSE2-NEXT:    movdqa {{.*#+}} xmm1 = [2047,2047,2047,2047]
; SSE2-NEXT:    movdqa %xmm0, %xmm3
; SSE2-NEXT:    pand %xmm1, %xmm3
; SSE2-NEXT:    psrld $1, %xmm3
; SSE2-NEXT:    movss {{.*#+}} xmm2 = xmm3[0],xmm2[1,2,3]
; SSE2-NEXT:    pslld $10, %xmm0
; SSE2-NEXT:    xorps %xmm3, %xmm3
; SSE2-NEXT:    movss {{.*#+}} xmm3 = xmm0[0],xmm3[1,2,3]
; SSE2-NEXT:    orps %xmm2, %xmm3
; SSE2-NEXT:    andps %xmm1, %xmm3
; SSE2-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm3
; SSE2-NEXT:    movdqa %xmm3, -{{[0-9]+}}(%rsp)
; SSE2-NEXT:    movzbl -{{[0-9]+}}(%rsp), %eax
; SSE2-NEXT:    movzbl -{{[0-9]+}}(%rsp), %edx
; SSE2-NEXT:    movzbl -{{[0-9]+}}(%rsp), %ecx
; SSE2-NEXT:    retq
;
; SSE41-LABEL: test_urem_vec:
; SSE41:       # %bb.0:
; SSE41-NEXT:    movd %edi, %xmm0
; SSE41-NEXT:    pinsrd $1, %esi, %xmm0
; SSE41-NEXT:    pinsrd $2, %edx, %xmm0
; SSE41-NEXT:    psubd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    pmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0
; SSE41-NEXT:    movdqa {{.*#+}} xmm1 = [2047,2047,2047,2047]
; SSE41-NEXT:    movdqa %xmm0, %xmm2
; SSE41-NEXT:    pand %xmm1, %xmm2
; SSE41-NEXT:    psrld $1, %xmm2
; SSE41-NEXT:    pblendw {{.*#+}} xmm2 = xmm2[0,1],xmm0[2,3,4,5,6,7]
; SSE41-NEXT:    pslld $10, %xmm0
; SSE41-NEXT:    pxor %xmm3, %xmm3
; SSE41-NEXT:    pblendw {{.*#+}} xmm3 = xmm0[0,1],xmm3[2,3,4,5,6,7]
; SSE41-NEXT:    por %xmm2, %xmm3
; SSE41-NEXT:    pand %xmm1, %xmm3
; SSE41-NEXT:    pcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm3
; SSE41-NEXT:    movd %xmm3, %eax
; SSE41-NEXT:    pextrb $4, %xmm3, %edx
; SSE41-NEXT:    pextrb $8, %xmm3, %ecx
; SSE41-NEXT:    # kill: def $al killed $al killed $eax
; SSE41-NEXT:    # kill: def $dl killed $dl killed $edx
; SSE41-NEXT:    # kill: def $cl killed $cl killed $ecx
; SSE41-NEXT:    retq
;
; AVX1-LABEL: test_urem_vec:
; AVX1:       # %bb.0:
; AVX1-NEXT:    vmovd %edi, %xmm0
; AVX1-NEXT:    vpinsrd $1, %esi, %xmm0, %xmm0
; AVX1-NEXT:    vpinsrd $2, %edx, %xmm0, %xmm0
; AVX1-NEXT:    vpsubd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vpmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vbroadcastss {{.*#+}} xmm1 = [2047,2047,2047,2047]
; AVX1-NEXT:    vpand %xmm1, %xmm0, %xmm2
; AVX1-NEXT:    vpsrld $1, %xmm2, %xmm2
; AVX1-NEXT:    vpblendw {{.*#+}} xmm2 = xmm2[0,1],xmm0[2,3,4,5,6,7]
; AVX1-NEXT:    vpslld $10, %xmm0, %xmm0
; AVX1-NEXT:    vpxor %xmm3, %xmm3, %xmm3
; AVX1-NEXT:    vpblendw {{.*#+}} xmm0 = xmm0[0,1],xmm3[2,3,4,5,6,7]
; AVX1-NEXT:    vpor %xmm0, %xmm2, %xmm0
; AVX1-NEXT:    vpand %xmm1, %xmm0, %xmm0
; AVX1-NEXT:    vpcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX1-NEXT:    vmovd %xmm0, %eax
; AVX1-NEXT:    vpextrb $4, %xmm0, %edx
; AVX1-NEXT:    vpextrb $8, %xmm0, %ecx
; AVX1-NEXT:    # kill: def $al killed $al killed $eax
; AVX1-NEXT:    # kill: def $dl killed $dl killed $edx
; AVX1-NEXT:    # kill: def $cl killed $cl killed $ecx
; AVX1-NEXT:    retq
;
; AVX2-LABEL: test_urem_vec:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovd %edi, %xmm0
; AVX2-NEXT:    vpinsrd $1, %esi, %xmm0, %xmm0
; AVX2-NEXT:    vpinsrd $2, %edx, %xmm0, %xmm0
; AVX2-NEXT:    vpsubd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX2-NEXT:    vpmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX2-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX2-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [2047,2047,2047,2047]
; AVX2-NEXT:    vpand %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX2-NEXT:    vpor %xmm1, %xmm0, %xmm0
; AVX2-NEXT:    vpand %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX2-NEXT:    vmovd %xmm0, %eax
; AVX2-NEXT:    vpextrb $4, %xmm0, %edx
; AVX2-NEXT:    vpextrb $8, %xmm0, %ecx
; AVX2-NEXT:    # kill: def $al killed $al killed $eax
; AVX2-NEXT:    # kill: def $dl killed $dl killed $edx
; AVX2-NEXT:    # kill: def $cl killed $cl killed $ecx
; AVX2-NEXT:    retq
;
; AVX512VL-LABEL: test_urem_vec:
; AVX512VL:       # %bb.0:
; AVX512VL-NEXT:    vmovd %edi, %xmm0
; AVX512VL-NEXT:    vpinsrd $1, %esi, %xmm0, %xmm0
; AVX512VL-NEXT:    vpinsrd $2, %edx, %xmm0, %xmm0
; AVX512VL-NEXT:    vpsubd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX512VL-NEXT:    vpmulld {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX512VL-NEXT:    vpsllvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm1
; AVX512VL-NEXT:    vpbroadcastd {{.*#+}} xmm2 = [2047,2047,2047,2047]
; AVX512VL-NEXT:    vpand %xmm2, %xmm0, %xmm0
; AVX512VL-NEXT:    vpsrlvd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; AVX512VL-NEXT:    vpternlogd $200, %xmm1, %xmm2, %xmm0
; AVX512VL-NEXT:    vpcmpgtd {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %k0
; AVX512VL-NEXT:    kshiftrw $1, %k0, %k1
; AVX512VL-NEXT:    kmovw %k1, %edx
; AVX512VL-NEXT:    kshiftrw $2, %k0, %k1
; AVX512VL-NEXT:    kmovw %k1, %ecx
; AVX512VL-NEXT:    kmovw %k0, %eax
; AVX512VL-NEXT:    # kill: def $al killed $al killed $eax
; AVX512VL-NEXT:    # kill: def $dl killed $dl killed $edx
; AVX512VL-NEXT:    # kill: def $cl killed $cl killed $ecx
; AVX512VL-NEXT:    retq
  %urem = urem <3 x i11> %X, <i11 6, i11 7, i11 -5>
  %cmp = icmp ne <3 x i11> %urem, <i11 0, i11 1, i11 2>
  ret <3 x i1> %cmp
}
