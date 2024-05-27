; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i386-unknown-unknown   | FileCheck %s --check-prefix=X32
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s --check-prefix=X64

define i32 @t1(i32 %t, i32 %val) nounwind {
; X32-LABEL: t1:
; X32:       # %bb.0:
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll %cl, %eax
; X32-NEXT:    retl
;
; X64-LABEL: t1:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    shll %cl, %eax
; X64-NEXT:    retq
       %shamt = and i32 %t, 31
       %res = shl i32 %val, %shamt
       ret i32 %res
}

define i32 @t2(i32 %t, i32 %val) nounwind {
; X32-LABEL: t2:
; X32:       # %bb.0:
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shll %cl, %eax
; X32-NEXT:    retl
;
; X64-LABEL: t2:
; X64:       # %bb.0:
; X64-NEXT:    movl %esi, %eax
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    shll %cl, %eax
; X64-NEXT:    retq
       %shamt = and i32 %t, 63
       %res = shl i32 %val, %shamt
       ret i32 %res
}

@X = internal global i16 0

define void @t3(i16 %t) nounwind {
; X32-LABEL: t3:
; X32:       # %bb.0:
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    sarw %cl, X
; X32-NEXT:    retl
;
; X64-LABEL: t3:
; X64:       # %bb.0:
; X64-NEXT:    movl %edi, %ecx
; X64-NEXT:    # kill: def $cl killed $cl killed $ecx
; X64-NEXT:    sarw %cl, X(%rip)
; X64-NEXT:    retq
       %shamt = and i16 %t, 31
       %tmp = load i16, ptr @X
       %tmp1 = ashr i16 %tmp, %shamt
       store i16 %tmp1, ptr @X
       ret void
}

define i64 @t4(i64 %t, i64 %val) nounwind {
; X32-LABEL: t4:
; X32:       # %bb.0:
; X32-NEXT:    pushl %esi
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NEXT:    movl %esi, %edx
; X32-NEXT:    shrl %cl, %edx
; X32-NEXT:    shrdl %cl, %esi, %eax
; X32-NEXT:    testb $32, %cl
; X32-NEXT:    je .LBB3_2
; X32-NEXT:  # %bb.1:
; X32-NEXT:    movl %edx, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:  .LBB3_2:
; X32-NEXT:    popl %esi
; X32-NEXT:    retl
;
; X64-LABEL: t4:
; X64:       # %bb.0:
; X64-NEXT:    movq %rsi, %rax
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NEXT:    shrq %cl, %rax
; X64-NEXT:    retq
       %shamt = and i64 %t, 63
       %res = lshr i64 %val, %shamt
       ret i64 %res
}

define i64 @t5(i64 %t, i64 %val) nounwind {
; X32-LABEL: t5:
; X32:       # %bb.0:
; X32-NEXT:    pushl %esi
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl {{[0-9]+}}(%esp), %esi
; X32-NEXT:    movl %esi, %edx
; X32-NEXT:    shrl %cl, %edx
; X32-NEXT:    shrdl %cl, %esi, %eax
; X32-NEXT:    testb $32, %cl
; X32-NEXT:    je .LBB4_2
; X32-NEXT:  # %bb.1:
; X32-NEXT:    movl %edx, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:  .LBB4_2:
; X32-NEXT:    popl %esi
; X32-NEXT:    retl
;
; X64-LABEL: t5:
; X64:       # %bb.0:
; X64-NEXT:    movq %rsi, %rax
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NEXT:    shrq %cl, %rax
; X64-NEXT:    retq
       %shamt = and i64 %t, 191
       %res = lshr i64 %val, %shamt
       ret i64 %res
}

define void @t5ptr(i64 %t, ptr %ptr) nounwind {
; X32-LABEL: t5ptr:
; X32:       # %bb.0:
; X32-NEXT:    pushl %edi
; X32-NEXT:    pushl %esi
; X32-NEXT:    movzbl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    movl (%eax), %edx
; X32-NEXT:    movl 4(%eax), %edi
; X32-NEXT:    movl %edi, %esi
; X32-NEXT:    shrl %cl, %esi
; X32-NEXT:    shrdl %cl, %edi, %edx
; X32-NEXT:    testb $32, %cl
; X32-NEXT:    je .LBB5_2
; X32-NEXT:  # %bb.1:
; X32-NEXT:    movl %esi, %edx
; X32-NEXT:    xorl %esi, %esi
; X32-NEXT:  .LBB5_2:
; X32-NEXT:    movl %edx, (%eax)
; X32-NEXT:    movl %esi, 4(%eax)
; X32-NEXT:    popl %esi
; X32-NEXT:    popl %edi
; X32-NEXT:    retl
;
; X64-LABEL: t5ptr:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rcx
; X64-NEXT:    # kill: def $cl killed $cl killed $rcx
; X64-NEXT:    shrq %cl, (%rsi)
; X64-NEXT:    retq
       %shamt = and i64 %t, 191
       %tmp = load i64, ptr %ptr
       %tmp1 = lshr i64 %tmp, %shamt
       store i64 %tmp1, ptr %ptr
       ret void
}


; rdar://11866926
define i64 @t6(i64 %key, ptr nocapture %val) nounwind {
; X32-LABEL: t6:
; X32:       # %bb.0:
; X32-NEXT:    pushl %esi
; X32-NEXT:    movl {{[0-9]+}}(%esp), %edx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    shrdl $3, %eax, %ecx
; X32-NEXT:    movl %eax, %esi
; X32-NEXT:    shrl $3, %esi
; X32-NEXT:    movl (%edx), %eax
; X32-NEXT:    movl 4(%edx), %edx
; X32-NEXT:    addl $-1, %eax
; X32-NEXT:    adcl $-1, %edx
; X32-NEXT:    andl %ecx, %eax
; X32-NEXT:    andl %esi, %edx
; X32-NEXT:    popl %esi
; X32-NEXT:    retl
;
; X64-LABEL: t6:
; X64:       # %bb.0:
; X64-NEXT:    shrq $3, %rdi
; X64-NEXT:    movq (%rsi), %rax
; X64-NEXT:    decq %rax
; X64-NEXT:    andq %rdi, %rax
; X64-NEXT:    retq
  %shr = lshr i64 %key, 3
  %1 = load i64, ptr %val, align 8
  %sub = add i64 %1, 2305843009213693951
  %and = and i64 %sub, %shr
  ret i64 %and
}

define i64 @big_mask_constant(i64 %x) nounwind {
; X32-LABEL: big_mask_constant:
; X32:       # %bb.0:
; X32-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X32-NEXT:    andl $4, %eax
; X32-NEXT:    shll $25, %eax
; X32-NEXT:    xorl %edx, %edx
; X32-NEXT:    retl
;
; X64-LABEL: big_mask_constant:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    shrq $7, %rax
; X64-NEXT:    andl $134217728, %eax # imm = 0x8000000
; X64-NEXT:    retq
  %and = and i64 %x, 17179869184 ; 0x400000000
  %sh = lshr i64 %and, 7
  ret i64 %sh
}

