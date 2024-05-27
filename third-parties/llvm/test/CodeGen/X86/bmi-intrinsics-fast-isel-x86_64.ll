; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -fast-isel -mtriple=x86_64-unknown-unknown -mattr=+bmi | FileCheck %s --check-prefix=X64
; RUN: llc < %s -fast-isel -mtriple=x86_64-unknown-unknown -mattr=+bmi,+egpr --show-mc-encoding | FileCheck %s --check-prefix=EGPR

; NOTE: This should use IR equivalent to what is generated by clang/test/CodeGen/bmi-builtins.c

;
; AMD Intrinsics
;

define i64 @test__andn_u64(i64 %a0, i64 %a1) {
; X64-LABEL: test__andn_u64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    xorq $-1, %rax
; X64-NEXT:    andq %rsi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test__andn_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    movq %rdi, %rax # encoding: [0x48,0x89,0xf8]
; EGPR-NEXT:    xorq $-1, %rax # encoding: [0x48,0x83,0xf0,0xff]
; EGPR-NEXT:    andq %rsi, %rax # encoding: [0x48,0x21,0xf0]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %xor = xor i64 %a0, -1
  %res = and i64 %xor, %a1
  ret i64 %res
}

define i64 @test__bextr_u64(i64 %a0, i64 %a1) {
; X64-LABEL: test__bextr_u64:
; X64:       # %bb.0:
; X64-NEXT:    bextrq %rsi, %rdi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test__bextr_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    bextrq %rsi, %rdi, %rax # EVEX TO VEX Compression encoding: [0xc4,0xe2,0xc8,0xf7,0xc7]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %res = call i64 @llvm.x86.bmi.bextr.64(i64 %a0, i64 %a1)
  ret i64 %res
}

define i64 @test__blsi_u64(i64 %a0) {
; X64-LABEL: test__blsi_u64:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    subq %rdi, %rax
; X64-NEXT:    andq %rdi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test__blsi_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; EGPR-NEXT:    subq %rdi, %rax # encoding: [0x48,0x29,0xf8]
; EGPR-NEXT:    andq %rdi, %rax # encoding: [0x48,0x21,0xf8]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %neg = sub i64 0, %a0
  %res = and i64 %a0, %neg
  ret i64 %res
}

define i64 @test__blsmsk_u64(i64 %a0) {
; X64-LABEL: test__blsmsk_u64:
; X64:       # %bb.0:
; X64-NEXT:    leaq -1(%rdi), %rax
; X64-NEXT:    xorq %rdi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test__blsmsk_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    leaq -1(%rdi), %rax # encoding: [0x48,0x8d,0x47,0xff]
; EGPR-NEXT:    xorq %rdi, %rax # encoding: [0x48,0x31,0xf8]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %dec = sub i64 %a0, 1
  %res = xor i64 %a0, %dec
  ret i64 %res
}

define i64 @test__blsr_u64(i64 %a0) {
; X64-LABEL: test__blsr_u64:
; X64:       # %bb.0:
; X64-NEXT:    leaq -1(%rdi), %rax
; X64-NEXT:    andq %rdi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test__blsr_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    leaq -1(%rdi), %rax # encoding: [0x48,0x8d,0x47,0xff]
; EGPR-NEXT:    andq %rdi, %rax # encoding: [0x48,0x21,0xf8]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %dec = sub i64 %a0, 1
  %res = and i64 %a0, %dec
  ret i64 %res
}

define i64 @test__tzcnt_u64(i64 %a0) {
; X64-LABEL: test__tzcnt_u64:
; X64:       # %bb.0:
; X64-NEXT:    tzcntq %rdi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test__tzcnt_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    tzcntq %rdi, %rax # encoding: [0xf3,0x48,0x0f,0xbc,0xc7]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %cmp = icmp ne i64 %a0, 0
  %cttz = call i64 @llvm.cttz.i64(i64 %a0, i1 false)
  ret i64 %cttz
}

;
; Intel intrinsics
;

define i64 @test_andn_u64(i64 %a0, i64 %a1) {
; X64-LABEL: test_andn_u64:
; X64:       # %bb.0:
; X64-NEXT:    movq %rdi, %rax
; X64-NEXT:    xorq $-1, %rax
; X64-NEXT:    andq %rsi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test_andn_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    movq %rdi, %rax # encoding: [0x48,0x89,0xf8]
; EGPR-NEXT:    xorq $-1, %rax # encoding: [0x48,0x83,0xf0,0xff]
; EGPR-NEXT:    andq %rsi, %rax # encoding: [0x48,0x21,0xf0]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %xor = xor i64 %a0, -1
  %res = and i64 %xor, %a1
  ret i64 %res
}

define i64 @test_bextr_u64(i64 %a0, i32 %a1, i32 %a2) {
; X64-LABEL: test_bextr_u64:
; X64:       # %bb.0:
; X64-NEXT:    andl $255, %esi
; X64-NEXT:    andl $255, %edx
; X64-NEXT:    shll $8, %edx
; X64-NEXT:    orl %esi, %edx
; X64-NEXT:    movl %edx, %eax
; X64-NEXT:    bextrq %rax, %rdi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test_bextr_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    andl $255, %esi # encoding: [0x81,0xe6,0xff,0x00,0x00,0x00]
; EGPR-NEXT:    andl $255, %edx # encoding: [0x81,0xe2,0xff,0x00,0x00,0x00]
; EGPR-NEXT:    shll $8, %edx # encoding: [0xc1,0xe2,0x08]
; EGPR-NEXT:    orl %esi, %edx # encoding: [0x09,0xf2]
; EGPR-NEXT:    movl %edx, %eax # encoding: [0x89,0xd0]
; EGPR-NEXT:    bextrq %rax, %rdi, %rax # EVEX TO VEX Compression encoding: [0xc4,0xe2,0xf8,0xf7,0xc7]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %and1 = and i32 %a1, 255
  %and2 = and i32 %a2, 255
  %shl = shl i32 %and2, 8
  %or = or i32 %and1, %shl
  %zext = zext i32 %or to i64
  %res = call i64 @llvm.x86.bmi.bextr.64(i64 %a0, i64 %zext)
  ret i64 %res
}

define i64 @test_blsi_u64(i64 %a0) {
; X64-LABEL: test_blsi_u64:
; X64:       # %bb.0:
; X64-NEXT:    xorl %eax, %eax
; X64-NEXT:    subq %rdi, %rax
; X64-NEXT:    andq %rdi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test_blsi_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    xorl %eax, %eax # encoding: [0x31,0xc0]
; EGPR-NEXT:    subq %rdi, %rax # encoding: [0x48,0x29,0xf8]
; EGPR-NEXT:    andq %rdi, %rax # encoding: [0x48,0x21,0xf8]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %neg = sub i64 0, %a0
  %res = and i64 %a0, %neg
  ret i64 %res
}

define i64 @test_blsmsk_u64(i64 %a0) {
; X64-LABEL: test_blsmsk_u64:
; X64:       # %bb.0:
; X64-NEXT:    leaq -1(%rdi), %rax
; X64-NEXT:    xorq %rdi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test_blsmsk_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    leaq -1(%rdi), %rax # encoding: [0x48,0x8d,0x47,0xff]
; EGPR-NEXT:    xorq %rdi, %rax # encoding: [0x48,0x31,0xf8]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %dec = sub i64 %a0, 1
  %res = xor i64 %a0, %dec
  ret i64 %res
}

define i64 @test_blsr_u64(i64 %a0) {
; X64-LABEL: test_blsr_u64:
; X64:       # %bb.0:
; X64-NEXT:    leaq -1(%rdi), %rax
; X64-NEXT:    andq %rdi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test_blsr_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    leaq -1(%rdi), %rax # encoding: [0x48,0x8d,0x47,0xff]
; EGPR-NEXT:    andq %rdi, %rax # encoding: [0x48,0x21,0xf8]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %dec = sub i64 %a0, 1
  %res = and i64 %a0, %dec
  ret i64 %res
}

define i64 @test_tzcnt_u64(i64 %a0) {
; X64-LABEL: test_tzcnt_u64:
; X64:       # %bb.0:
; X64-NEXT:    tzcntq %rdi, %rax
; X64-NEXT:    retq
;
; EGPR-LABEL: test_tzcnt_u64:
; EGPR:       # %bb.0:
; EGPR-NEXT:    tzcntq %rdi, %rax # encoding: [0xf3,0x48,0x0f,0xbc,0xc7]
; EGPR-NEXT:    retq # encoding: [0xc3]
  %cmp = icmp ne i64 %a0, 0
  %cttz = call i64 @llvm.cttz.i64(i64 %a0, i1 false)
  ret i64 %cttz
}

declare i64 @llvm.cttz.i64(i64, i1)
declare i64 @llvm.x86.bmi.bextr.64(i64, i64)
