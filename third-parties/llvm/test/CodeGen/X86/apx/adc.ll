; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown -mattr=+ndd -verify-machineinstrs --show-mc-encoding | FileCheck %s

define i8 @adc8rr(i8 %a, i8 %b, i8 %x, i8 %y) nounwind {
; CHECK-LABEL: adc8rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subb %dl, %cl, %al # encoding: [0x62,0xf4,0x7c,0x18,0x28,0xd1]
; CHECK-NEXT:    adcb %sil, %dil, %al # encoding: [0x62,0xf4,0x7c,0x18,0x10,0xf7]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i8 %a, %b
  %k = icmp ugt i8 %x, %y
  %z = zext i1 %k to i8
  %r = add i8 %s, %z
  ret i8 %r
}

define i16 @adc16rr(i16 %a, i16 %b, i16 %x, i16 %y) nounwind {
; CHECK-LABEL: adc16rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subw %dx, %cx, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x29,0xd1]
; CHECK-NEXT:    adcw %si, %di, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x11,0xf7]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i16 %a, %b
  %k = icmp ugt i16 %x, %y
  %z = zext i1 %k to i16
  %r = add i16 %s, %z
  ret i16 %r
}

define i32 @adc32rr(i32 %a, i32 %b, i32 %x, i32 %y) nounwind {
; CHECK-LABEL: adc32rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subl %edx, %ecx, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x29,0xd1]
; CHECK-NEXT:    adcl %esi, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x11,0xf7]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i32 %a, %b
  %k = icmp ugt i32 %x, %y
  %z = zext i1 %k to i32
  %r = add i32 %s, %z
  ret i32 %r
}

define i64 @adc64rr(i64 %a, i64 %b, i64 %x, i64 %y) nounwind {
; CHECK-LABEL: adc64rr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq %rdx, %rcx, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x29,0xd1]
; CHECK-NEXT:    adcq %rsi, %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x11,0xf7]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i64 %a, %b
  %k = icmp ugt i64 %x, %y
  %z = zext i1 %k to i64
  %r = add i64 %s, %z
  ret i64 %r
}

define i8 @adc8rm(i8 %a, ptr %ptr, i8 %x, i8 %y) nounwind {
; CHECK-LABEL: adc8rm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subb %dl, %cl, %al # encoding: [0x62,0xf4,0x7c,0x18,0x28,0xd1]
; CHECK-NEXT:    adcb (%rsi), %dil, %al # encoding: [0x62,0xf4,0x7c,0x18,0x12,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i8, ptr %ptr
  %s = add i8 %a, %b
  %k = icmp ugt i8 %x, %y
  %z = zext i1 %k to i8
  %r = add i8 %s, %z
  ret i8 %r
}

define i16 @adc16rm(i16 %a, ptr %ptr, i16 %x, i16 %y) nounwind {
; CHECK-LABEL: adc16rm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subw %dx, %cx, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x29,0xd1]
; CHECK-NEXT:    adcw (%rsi), %di, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x13,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i16, ptr %ptr
  %s = add i16 %a, %b
  %k = icmp ugt i16 %x, %y
  %z = zext i1 %k to i16
  %r = add i16 %s, %z
  ret i16 %r
}

define i32 @adc32rm(i32 %a, ptr %ptr, i32 %x, i32 %y) nounwind {
; CHECK-LABEL: adc32rm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subl %edx, %ecx, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x29,0xd1]
; CHECK-NEXT:    adcl (%rsi), %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x13,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i32, ptr %ptr
  %s = add i32 %a, %b
  %k = icmp ugt i32 %x, %y
  %z = zext i1 %k to i32
  %r = add i32 %s, %z
  ret i32 %r
}

define i64 @adc64rm(i64 %a, ptr %ptr, i64 %x, i64 %y) nounwind {
; CHECK-LABEL: adc64rm:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq %rdx, %rcx, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x29,0xd1]
; CHECK-NEXT:    adcq (%rsi), %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x13,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i64, ptr %ptr
  %s = add i64 %a, %b
  %k = icmp ugt i64 %x, %y
  %z = zext i1 %k to i64
  %r = add i64 %s, %z
  ret i64 %r
}

define i16 @adc16ri8(i16 %a, i16 %x, i16 %y) nounwind {
; CHECK-LABEL: adc16ri8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subw %si, %dx, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x29,0xf2]
; CHECK-NEXT:    adcw $0, %di, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x81,0xd7,0x00,0x00]
; CHECK-NEXT:    addl $123, %eax # EVEX TO LEGACY Compression encoding: [0x83,0xc0,0x7b]
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i16 %a, 123
  %k = icmp ugt i16 %x, %y
  %z = zext i1 %k to i16
  %r = add i16 %s, %z
  ret i16 %r
}

define i32 @adc32ri8(i32 %a, i32 %x, i32 %y) nounwind {
; CHECK-LABEL: adc32ri8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subl %esi, %edx, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x29,0xf2]
; CHECK-NEXT:    adcl $123, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x81,0xd7,0x7b,0x00,0x00,0x00]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i32 %a, 123
  %k = icmp ugt i32 %x, %y
  %z = zext i1 %k to i32
  %r = add i32 %s, %z
  ret i32 %r
}

define i64 @adc64ri8(i64 %a, i64 %x, i64 %y) nounwind {
; CHECK-LABEL: adc64ri8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq %rsi, %rdx, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x29,0xf2]
; CHECK-NEXT:    adcq $123, %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x81,0xd7,0x7b,0x00,0x00,0x00]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i64 %a, 123
  %k = icmp ugt i64 %x, %y
  %z = zext i1 %k to i64
  %r = add i64 %s, %z
  ret i64 %r
}

define i8 @adc8ri(i8 %a, i8 %x, i8 %y) nounwind {
; CHECK-LABEL: adc8ri:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subb %sil, %dl, %al # encoding: [0x62,0xf4,0x7c,0x18,0x28,0xf2]
; CHECK-NEXT:    adcb $123, %dil, %al # encoding: [0x62,0xf4,0x7c,0x18,0x80,0xd7,0x7b]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i8 %a, 123
  %k = icmp ugt i8 %x, %y
  %z = zext i1 %k to i8
  %r = add i8 %s, %z
  ret i8 %r
}

define i16 @adc16ri(i16 %a, i16 %x, i16 %y) nounwind {
; CHECK-LABEL: adc16ri:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subw %si, %dx, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x29,0xf2]
; CHECK-NEXT:    adcw $0, %di, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x81,0xd7,0x00,0x00]
; CHECK-NEXT:    addl $1234, %eax # EVEX TO LEGACY Compression encoding: [0x05,0xd2,0x04,0x00,0x00]
; CHECK-NEXT:    # imm = 0x4D2
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i16 %a, 1234
  %k = icmp ugt i16 %x, %y
  %z = zext i1 %k to i16
  %r = add i16 %s, %z
  ret i16 %r
}

define i32 @adc32ri(i32 %a, i32 %x, i32 %y) nounwind {
; CHECK-LABEL: adc32ri:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subl %esi, %edx, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x29,0xf2]
; CHECK-NEXT:    adcl $123456, %edi, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x81,0xd7,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i32 %a, 123456
  %k = icmp ugt i32 %x, %y
  %z = zext i1 %k to i32
  %r = add i32 %s, %z
  ret i32 %r
}

define i64 @adc64ri(i64 %a, i64 %x, i64 %y) nounwind {
; CHECK-LABEL: adc64ri:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq %rsi, %rdx, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x29,0xf2]
; CHECK-NEXT:    adcq $123456, %rdi, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x81,0xd7,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
  %s = add i64 %a, 123456
  %k = icmp ugt i64 %x, %y
  %z = zext i1 %k to i64
  %r = add i64 %s, %z
  ret i64 %r
}

define i8 @adc8mr(i8 %a, ptr %ptr, i8 %x, i8 %y) nounwind {
; CHECK-LABEL: adc8mr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subb %dl, %cl, %al # encoding: [0x62,0xf4,0x7c,0x18,0x28,0xd1]
; CHECK-NEXT:    adcb %dil, (%rsi), %al # encoding: [0x62,0xf4,0x7c,0x18,0x10,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i8, ptr %ptr
  %s = add i8 %b, %a
  %k = icmp ugt i8 %x, %y
  %z = zext i1 %k to i8
  %r = add i8 %s, %z
  ret i8 %r
}

define i16 @adc16mr(i16 %a, ptr %ptr, i16 %x, i16 %y) nounwind {
; CHECK-LABEL: adc16mr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subw %dx, %cx, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x29,0xd1]
; CHECK-NEXT:    adcw %di, (%rsi), %ax # encoding: [0x62,0xf4,0x7d,0x18,0x11,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i16, ptr %ptr
  %s = add i16 %b, %a
  %k = icmp ugt i16 %x, %y
  %z = zext i1 %k to i16
  %r = add i16 %s, %z
  ret i16 %r
}

define i32 @adc32mr(i32 %a, ptr %ptr, i32 %x, i32 %y) nounwind {
; CHECK-LABEL: adc32mr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subl %edx, %ecx, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x29,0xd1]
; CHECK-NEXT:    adcl %edi, (%rsi), %eax # encoding: [0x62,0xf4,0x7c,0x18,0x11,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i32, ptr %ptr
  %s = add i32 %b, %a
  %k = icmp ugt i32 %x, %y
  %z = zext i1 %k to i32
  %r = add i32 %s, %z
  ret i32 %r
}

define i64 @adc64mr(i64 %a, ptr %ptr, i64 %x, i64 %y) nounwind {
; CHECK-LABEL: adc64mr:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq %rdx, %rcx, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x29,0xd1]
; CHECK-NEXT:    adcq %rdi, (%rsi), %rax # encoding: [0x62,0xf4,0xfc,0x18,0x11,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i64, ptr %ptr
  %s = add i64 %b, %a
  %k = icmp ugt i64 %x, %y
  %z = zext i1 %k to i64
  %r = add i64 %s, %z
  ret i64 %r
}

define i16 @adc16mi8(ptr %ptr, i16 %x, i16 %y) nounwind {
; CHECK-LABEL: adc16mi8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subw %si, %dx, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x29,0xf2]
; CHECK-NEXT:    adcw $0, (%rdi), %ax # encoding: [0x62,0xf4,0x7d,0x18,0x81,0x17,0x00,0x00]
; CHECK-NEXT:    addl $123, %eax # EVEX TO LEGACY Compression encoding: [0x83,0xc0,0x7b]
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i16, ptr %ptr
  %s = add i16 %a, 123
  %k = icmp ugt i16 %x, %y
  %z = zext i1 %k to i16
  %r = add i16 %s, %z
  ret i16 %r
}

define i32 @adc32mi8(ptr %ptr, i32 %x, i32 %y) nounwind {
; CHECK-LABEL: adc32mi8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subl %esi, %edx, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x29,0xf2]
; CHECK-NEXT:    adcl $123, (%rdi), %eax # encoding: [0x62,0xf4,0x7c,0x18,0x81,0x17,0x7b,0x00,0x00,0x00]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i32, ptr %ptr
  %s = add i32 %a, 123
  %k = icmp ugt i32 %x, %y
  %z = zext i1 %k to i32
  %r = add i32 %s, %z
  ret i32 %r
}

define i64 @adc64mi8(ptr %ptr, i64 %x, i64 %y) nounwind {
; CHECK-LABEL: adc64mi8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq %rsi, %rdx, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x29,0xf2]
; CHECK-NEXT:    adcq $123, (%rdi), %rax # encoding: [0x62,0xf4,0xfc,0x18,0x81,0x17,0x7b,0x00,0x00,0x00]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i64, ptr %ptr
  %s = add i64 %a, 123
  %k = icmp ugt i64 %x, %y
  %z = zext i1 %k to i64
  %r = add i64 %s, %z
  ret i64 %r
}

define i8 @adc8mi(ptr %ptr, i8 %x, i8 %y) nounwind {
; CHECK-LABEL: adc8mi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subb %sil, %dl, %al # encoding: [0x62,0xf4,0x7c,0x18,0x28,0xf2]
; CHECK-NEXT:    adcb $123, (%rdi), %al # encoding: [0x62,0xf4,0x7c,0x18,0x80,0x17,0x7b]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i8, ptr %ptr
  %s = add i8 %a, 123
  %k = icmp ugt i8 %x, %y
  %z = zext i1 %k to i8
  %r = add i8 %s, %z
  ret i8 %r
}

define i16 @adc16mi(ptr %ptr, i16 %x, i16 %y) nounwind {
; CHECK-LABEL: adc16mi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subw %si, %dx, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x29,0xf2]
; CHECK-NEXT:    adcw $0, (%rdi), %ax # encoding: [0x62,0xf4,0x7d,0x18,0x81,0x17,0x00,0x00]
; CHECK-NEXT:    addl $1234, %eax # EVEX TO LEGACY Compression encoding: [0x05,0xd2,0x04,0x00,0x00]
; CHECK-NEXT:    # imm = 0x4D2
; CHECK-NEXT:    # kill: def $ax killed $ax killed $eax
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i16, ptr %ptr
  %s = add i16 %a, 1234
  %k = icmp ugt i16 %x, %y
  %z = zext i1 %k to i16
  %r = add i16 %s, %z
  ret i16 %r
}

define i32 @adc32mi(ptr %ptr, i32 %x, i32 %y) nounwind {
; CHECK-LABEL: adc32mi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subl %esi, %edx, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x29,0xf2]
; CHECK-NEXT:    adcl $123456, (%rdi), %eax # encoding: [0x62,0xf4,0x7c,0x18,0x81,0x17,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i32, ptr %ptr
  %s = add i32 %a, 123456
  %k = icmp ugt i32 %x, %y
  %z = zext i1 %k to i32
  %r = add i32 %s, %z
  ret i32 %r
}

define i64 @adc64mi(ptr %ptr, i64 %x, i64 %y) nounwind {
; CHECK-LABEL: adc64mi:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq %rsi, %rdx, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x29,0xf2]
; CHECK-NEXT:    adcq $123456, (%rdi), %rax # encoding: [0x62,0xf4,0xfc,0x18,0x81,0x17,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i64, ptr %ptr
  %s = add i64 %a, 123456
  %k = icmp ugt i64 %x, %y
  %z = zext i1 %k to i64
  %r = add i64 %s, %z
  ret i64 %r
}

define void @adc8mr_legacy(i8 %a, ptr %ptr, i8 %x, i8 %y) nounwind {
; CHECK-LABEL: adc8mr_legacy:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subb %dl, %cl, %al # encoding: [0x62,0xf4,0x7c,0x18,0x28,0xd1]
; CHECK-NEXT:    adcb %dil, (%rsi) # encoding: [0x40,0x10,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i8, ptr %ptr
  %s = add i8 %b, %a
  %k = icmp ugt i8 %x, %y
  %z = zext i1 %k to i8
  %r = add i8 %s, %z
  store i8 %r, ptr %ptr
  ret void
}

define void @adc16mr_legacy(i16 %a, ptr %ptr, i16 %x, i16 %y) nounwind {
; CHECK-LABEL: adc16mr_legacy:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subw %dx, %cx, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x29,0xd1]
; CHECK-NEXT:    adcw %di, (%rsi) # encoding: [0x66,0x11,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i16, ptr %ptr
  %s = add i16 %b, %a
  %k = icmp ugt i16 %x, %y
  %z = zext i1 %k to i16
  %r = add i16 %s, %z
  store i16 %r, ptr %ptr
  ret void
}

define void @adc32mr_legacy(i32 %a, ptr %ptr, i32 %x, i32 %y) nounwind {
; CHECK-LABEL: adc32mr_legacy:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subl %edx, %ecx, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x29,0xd1]
; CHECK-NEXT:    adcl %edi, (%rsi) # encoding: [0x11,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i32, ptr %ptr
  %s = add i32 %b, %a
  %k = icmp ugt i32 %x, %y
  %z = zext i1 %k to i32
  %r = add i32 %s, %z
  store i32 %r, ptr %ptr
  ret void
}

define void @adc64mr_legacy(i64 %a, ptr %ptr, i64 %x, i64 %y) nounwind {
; CHECK-LABEL: adc64mr_legacy:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq %rdx, %rcx, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x29,0xd1]
; CHECK-NEXT:    adcq %rdi, (%rsi) # encoding: [0x48,0x11,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %b = load i64, ptr %ptr
  %s = add i64 %b, %a
  %k = icmp ugt i64 %x, %y
  %z = zext i1 %k to i64
  %r = add i64 %s, %z
  store i64 %r, ptr %ptr
  ret void
}

define void @adc8mi_legacy(ptr %ptr, i8 %x, i8 %y) nounwind {
; CHECK-LABEL: adc8mi_legacy:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subb %sil, %dl, %al # encoding: [0x62,0xf4,0x7c,0x18,0x28,0xf2]
; CHECK-NEXT:    adcb $123, (%rdi) # encoding: [0x80,0x17,0x7b]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i8, ptr %ptr
  %s = add i8 %a, 123
  %k = icmp ugt i8 %x, %y
  %z = zext i1 %k to i8
  %r = add i8 %s, %z
  store i8 %r, ptr %ptr
  ret void
}

define void @adc16mi_legacy(ptr %ptr, i16 %x, i16 %y) nounwind {
; CHECK-LABEL: adc16mi_legacy:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subw %si, %dx, %ax # encoding: [0x62,0xf4,0x7d,0x18,0x29,0xf2]
; CHECK-NEXT:    adcw $0, (%rdi), %ax # encoding: [0x62,0xf4,0x7d,0x18,0x81,0x17,0x00,0x00]
; CHECK-NEXT:    addl $1234, %eax # EVEX TO LEGACY Compression encoding: [0x05,0xd2,0x04,0x00,0x00]
; CHECK-NEXT:    # imm = 0x4D2
; CHECK-NEXT:    movw %ax, (%rdi) # encoding: [0x66,0x89,0x07]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i16, ptr %ptr
  %s = add i16 %a, 1234
  %k = icmp ugt i16 %x, %y
  %z = zext i1 %k to i16
  %r = add i16 %s, %z
  store i16 %r, ptr %ptr
  ret void
}

define void @adc32mi_legacy(ptr %ptr, i32 %x, i32 %y) nounwind {
; CHECK-LABEL: adc32mi_legacy:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subl %esi, %edx, %eax # encoding: [0x62,0xf4,0x7c,0x18,0x29,0xf2]
; CHECK-NEXT:    adcl $123456, (%rdi) # encoding: [0x81,0x17,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i32, ptr %ptr
  %s = add i32 %a, 123456
  %k = icmp ugt i32 %x, %y
  %z = zext i1 %k to i32
  %r = add i32 %s, %z
  store i32 %r, ptr %ptr
  ret void
}

define void @adc64mi_legacy(ptr %ptr, i64 %x, i64 %y) nounwind {
; CHECK-LABEL: adc64mi_legacy:
; CHECK:       # %bb.0:
; CHECK-NEXT:    subq %rsi, %rdx, %rax # encoding: [0x62,0xf4,0xfc,0x18,0x29,0xf2]
; CHECK-NEXT:    adcq $123456, (%rdi) # encoding: [0x48,0x81,0x17,0x40,0xe2,0x01,0x00]
; CHECK-NEXT:    # imm = 0x1E240
; CHECK-NEXT:    retq # encoding: [0xc3]
  %a = load i64, ptr %ptr
  %s = add i64 %a, 123456
  %k = icmp ugt i64 %x, %y
  %z = zext i1 %k to i64
  %r = add i64 %s, %z
  store i64 %r, ptr %ptr
  ret void
}
