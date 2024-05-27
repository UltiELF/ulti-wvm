; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown | FileCheck %s

define void @main.41() local_unnamed_addr #1 {
; CHECK-LABEL: main.41:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vpbroadcastw (%rax), %xmm0
; CHECK-NEXT:    vmovdqu (%rax), %ymm2
; CHECK-NEXT:    vinserti128 $1, %xmm0, %ymm0, %ymm3
; CHECK-NEXT:    vmovdqa {{.*#+}} ymm1 = [31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]
; CHECK-NEXT:    vpermi2w %ymm3, %ymm2, %ymm1
; CHECK-NEXT:    vpextrw $0, %xmm0, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm0
; CHECK-NEXT:    vcvtph2ps %xmm0, %xmm0
; CHECK-NEXT:    vmovdqu (%rax), %xmm5
; CHECK-NEXT:    vpextrw $0, %xmm5, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm2
; CHECK-NEXT:    vcvtph2ps %xmm2, %xmm2
; CHECK-NEXT:    vucomiss %xmm0, %xmm2
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    vpsrld $16, %xmm1, %xmm3
; CHECK-NEXT:    vpextrw $0, %xmm3, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm3
; CHECK-NEXT:    vpsrld $16, %xmm5, %xmm4
; CHECK-NEXT:    vpextrw $0, %xmm4, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm4
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    andl $1, %eax
; CHECK-NEXT:    vcvtph2ps %xmm3, %xmm6
; CHECK-NEXT:    vcvtph2ps %xmm4, %xmm3
; CHECK-NEXT:    kmovw %eax, %k0
; CHECK-NEXT:    vucomiss %xmm6, %xmm3
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $14, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-5, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vprolq $32, %xmm1, %xmm4
; CHECK-NEXT:    vpextrw $0, %xmm4, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm4
; CHECK-NEXT:    vcvtph2ps %xmm4, %xmm4
; CHECK-NEXT:    vucomiss %xmm4, %xmm0
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $13, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-9, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    vpsrlq $48, %xmm1, %xmm4
; CHECK-NEXT:    vpextrw $0, %xmm4, %eax
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm4
; CHECK-NEXT:    vcvtph2ps %xmm4, %xmm6
; CHECK-NEXT:    vpsrlq $48, %xmm5, %xmm4
; CHECK-NEXT:    vpextrw $0, %xmm4, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm4
; CHECK-NEXT:    vcvtph2ps %xmm4, %xmm4
; CHECK-NEXT:    vucomiss %xmm6, %xmm4
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $12, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-17, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    vpshufd {{.*#+}} xmm6 = xmm1[2,3,0,1]
; CHECK-NEXT:    vpextrw $0, %xmm6, %eax
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm6
; CHECK-NEXT:    vcvtph2ps %xmm6, %xmm6
; CHECK-NEXT:    vucomiss %xmm6, %xmm0
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $11, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-33, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm6 = xmm1[10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpextrw $0, %xmm6, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm6
; CHECK-NEXT:    vcvtph2ps %xmm6, %xmm7
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm6 = xmm5[10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpextrw $0, %xmm6, %eax
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm6
; CHECK-NEXT:    vcvtph2ps %xmm6, %xmm6
; CHECK-NEXT:    vucomiss %xmm7, %xmm6
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $10, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-65, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vpshufd {{.*#+}} xmm7 = xmm1[3,3,3,3]
; CHECK-NEXT:    vpextrw $0, %xmm7, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm7
; CHECK-NEXT:    vcvtph2ps %xmm7, %xmm7
; CHECK-NEXT:    vucomiss %xmm7, %xmm0
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $9, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-129, %ax
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm7 = xmm1[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpextrw $0, %xmm7, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm7
; CHECK-NEXT:    vcvtph2ps %xmm7, %xmm7
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm5 = xmm5[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpextrw $0, %xmm5, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm5
; CHECK-NEXT:    vcvtph2ps %xmm5, %xmm5
; CHECK-NEXT:    vucomiss %xmm7, %xmm5
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $8, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-257, %ax # imm = 0xFEFF
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vextracti128 $1, %ymm1, %xmm1
; CHECK-NEXT:    vpextrw $0, %xmm1, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm7
; CHECK-NEXT:    vcvtph2ps %xmm7, %xmm7
; CHECK-NEXT:    vucomiss %xmm7, %xmm2
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $7, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-513, %ax # imm = 0xFDFF
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vpsrld $16, %xmm1, %xmm2
; CHECK-NEXT:    vpextrw $0, %xmm2, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm2
; CHECK-NEXT:    vcvtph2ps %xmm2, %xmm2
; CHECK-NEXT:    vucomiss %xmm2, %xmm3
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $6, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-1025, %ax # imm = 0xFBFF
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    vprolq $32, %xmm1, %xmm2
; CHECK-NEXT:    vpextrw $0, %xmm2, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm2
; CHECK-NEXT:    vcvtph2ps %xmm2, %xmm2
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vucomiss %xmm2, %xmm0
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $5, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-2049, %ax # imm = 0xF7FF
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vpsrlq $48, %xmm1, %xmm2
; CHECK-NEXT:    vpextrw $0, %xmm2, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm2
; CHECK-NEXT:    vcvtph2ps %xmm2, %xmm2
; CHECK-NEXT:    vucomiss %xmm2, %xmm4
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $4, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-4097, %ax # imm = 0xEFFF
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    vpshufd {{.*#+}} xmm2 = xmm1[2,3,0,1]
; CHECK-NEXT:    vpextrw $0, %xmm2, %eax
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm2
; CHECK-NEXT:    vcvtph2ps %xmm2, %xmm2
; CHECK-NEXT:    vucomiss %xmm2, %xmm0
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $3, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-8193, %ax # imm = 0xDFFF
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm2 = xmm1[10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpextrw $0, %xmm2, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm2
; CHECK-NEXT:    vcvtph2ps %xmm2, %xmm2
; CHECK-NEXT:    vucomiss %xmm2, %xmm6
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    kshiftrw $2, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    movw $-16385, %ax # imm = 0xBFFF
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kandw %k1, %k0, %k0
; CHECK-NEXT:    vpshufd {{.*#+}} xmm2 = xmm1[3,3,3,3]
; CHECK-NEXT:    vpextrw $0, %xmm2, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm2
; CHECK-NEXT:    vcvtph2ps %xmm2, %xmm2
; CHECK-NEXT:    vucomiss %xmm2, %xmm0
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $14, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k0
; CHECK-NEXT:    kshiftlw $1, %k0, %k0
; CHECK-NEXT:    vpsrldq {{.*#+}} xmm0 = xmm1[14,15],zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero,zero
; CHECK-NEXT:    vpextrw $0, %xmm0, %eax
; CHECK-NEXT:    movzwl %ax, %eax
; CHECK-NEXT:    vmovd %eax, %xmm0
; CHECK-NEXT:    vcvtph2ps %xmm0, %xmm0
; CHECK-NEXT:    kshiftrw $1, %k0, %k0
; CHECK-NEXT:    vucomiss %xmm0, %xmm5
; CHECK-NEXT:    setnp %al
; CHECK-NEXT:    sete %cl
; CHECK-NEXT:    testb %al, %cl
; CHECK-NEXT:    setne %al
; CHECK-NEXT:    kmovd %eax, %k1
; CHECK-NEXT:    kshiftlw $15, %k1, %k1
; CHECK-NEXT:    korw %k1, %k0, %k1
; CHECK-NEXT:    vmovdqu8 {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0 {%k1} {z}
; CHECK-NEXT:    vmovdqa %xmm0, (%rax)
; CHECK-NEXT:    vzeroupper
; CHECK-NEXT:    retq
entry:
  %.pre = load half, ptr undef, align 16
  %vector.recur.init = insertelement <16 x half> poison, half %.pre, i64 15
  %wide.load = load <16 x half>, ptr undef, align 2
  %0 = shufflevector <16 x half> %vector.recur.init, <16 x half> %wide.load, <16 x i32> <i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30>
  %1 = fcmp oeq <16 x half> %wide.load, %0
  %2 = zext <16 x i1> %1 to <16 x i8>
  store <16 x i8> %2, ptr undef, align 16
  ret void
}

attributes #1 = { nounwind uwtable "target-cpu"="skx" }
